//
//  Authenticate.swift
//  Patreon
//
//  Created by Foti Dim on 07.03.18.
//  Copyright © 2018 FotiDim. All rights reserved.
//

import UIKit

let baseURL = URL(string: "https://www.patreon.com/api/oauth2/api")

public class Patreon: NSObject {
    
    public func profile(accessToken: String? = nil, completion: ((Result<Profile>) -> Void)?) {
        let url = baseURL?.appendingPathComponent("current_user")
        var request = URLRequest(url: url!)
        
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
                        print ("dataTaskWithRequest HTTP status code:", statusCode)
                        return;
                    }
                }
                
                if let jsonData = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let profile = try decoder.decode(Profile.self, from: jsonData)
                        completion?(.success(profile))
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
