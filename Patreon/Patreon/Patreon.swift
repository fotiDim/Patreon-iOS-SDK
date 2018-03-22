//
//  Authenticate.swift
//  Patreon
//
//  Created by Foti Dim on 07.03.18.
//  Copyright © 2018 FotiDim. All rights reserved.
//

import UIKit

var urlComponents = URLComponents()

public class Patreon {
    
    public init() {
        urlComponents.scheme = "https"
        urlComponents.host = "www.patreon.com"
    }
    
    public func profile(accessToken: String? = nil, completion: ((Result<Profile>) -> Void)?) {
        resource("current_user", modelType: Profile.self) { (result) in
            completion?(result)
        }
    }
    
    public func campaigns(accessToken: String? = nil, completion: ((Result<Campaigns>) -> Void)?) {
        resource("current_user/campaigns", modelType: Campaigns.self) { (result) in
            completion?(result)
        }
    }
    
    public func pledges(campaignID: String, accessToken: String? = nil, completion: ((Result<Pledges>) -> Void)?) {
        resource("campaigns/\(campaignID)/pledges", queries: [URLQueryItem(name: "include", value: "patron.null")], modelType: Pledges.self) { (result) in
            completion?(result)
        }
    }

    private func resource<T: Codable>(_ resource: String, queries: [URLQueryItem] = [], modelType: T.Type, accessToken: String? = nil, completion: ((Result<T>) -> Void)?) {
        urlComponents.path = "/api/oauth2/api/" + resource
        urlComponents.queryItems = queries
        var request = URLRequest(url: urlComponents.url!)
        
        if accessToken == nil {
            if let data = KeyChain.load(key: "AccessToken"),
                let result = String(data: data, encoding: String.Encoding.utf8){
                request.setValue("Bearer " + result, forHTTPHeaderField: "Authorization")
            }
        }
        else {
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
            
        }
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion?(.failure(error))
                }
                else if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    if (statusCode != 200) {
                        let error = HTTPStatusCode(rawValue: statusCode)!
                        completion?(.failure(error))
                        return
                    }
                }
                
                if let jsonData = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
                    
                    do {
                        let model = try decoder.decode(modelType, from: jsonData)
                        completion?(.success(model))
                    } catch {
                        completion?(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
