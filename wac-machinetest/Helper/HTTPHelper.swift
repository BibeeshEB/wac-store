//
//  HTTPHelper.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//

import Foundation

enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

class HttpRequestHelper {
    func GET(url: String, params: [String: String], httpHeader: [String:String], complete: @escaping (Bool, Data?) -> ()) {
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = httpHeader
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("Something went wrong: " + error!.localizedDescription as String)
                complete(false, nil)
                return
            } else {
                guard let data = data else {
                    print("Error: did not receive data")
                    complete(false, nil)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    let jsonDict = json as! [String:AnyObject]
                    let data = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
                    complete(true, data)
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }).resume()
        
    }
    
}
