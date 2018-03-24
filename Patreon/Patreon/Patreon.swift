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
        func requestFor(resource: String) -> URLRequest {
            urlComponents.path = "/api/oauth2/api/" + resource
            urlComponents.queryItems = queries
            return URLRequest(url: urlComponents.url!)
        }
        
        func urlRequest(_ request: URLRequest, withAccessToken accessToken: String?) -> URLRequest {
            var authenticatedRequest = request
            if let accessToken = accessToken {
                authenticatedRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
            }
            else {
                if let accessTokenData = KeyChain.load(key: "AccessToken"),
                    let accessToken = String(data: accessTokenData, encoding: String.Encoding.utf8){
                    authenticatedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
                }
            }
            return authenticatedRequest
        }
        
        func fetchData(of modelType: T.Type, using request: URLRequest, _ completion: ((Result<T>) -> Void)?) {
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion?(.failure(error))
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                        if let httpError = HTTPStatusCode(rawValue: httpResponse.statusCode) {
                            completion?(.failure(httpError))
                        }
                        return
                    }
                    
                    guard let jsonData = data else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                        completion?(.failure(error))
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
                    
                    do {
                        let model = try decoder.decode(modelType, from: jsonData)
                        completion?(.success(model))
                    } catch {
                        completion?(.failure(error))
                    }
                }
            }
            
            task.resume()
        }
        
        var request = requestFor(resource: resource)
        request = urlRequest(request, withAccessToken: accessToken)
        fetchData(of: modelType, using: request, completion)
    }
}
