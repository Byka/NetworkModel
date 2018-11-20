//
//  NetworkManager.swift
//  NetworkModel
//
//  Created by sbyka on 19/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit
import SystemConfiguration

public typealias networkSuccessHandler = (_ response: URLResponse?, _ json: Any) -> Void
public typealias networkFailureHandler = (_ response: URLResponse?, _ error: Error?) -> Void


class NetworkManager: NSObject {
    // This method can be used for get the data from the web service.
    // This class is treated as network manager wrapper calss.
    
    // - Parameters:
    // - url: hosted network url
    // - requestBody: sendign request details through the web service
    // - completionHandler: Transfer the JSON data throught success completion block if web service is success
    // - FailureHandler: Return the Failure resions if any web service is failed to get the data.
    
    
    
    
    class func post(_ url: URL, _ requestBody: AnyObject, _ successHandler: @escaping networkSuccessHandler, _ failureHandler: @escaping networkFailureHandler) -> Void {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if let errorMessage = error {
                    failureHandler(response, errorMessage)
                    print(errorMessage)
                }else {
                    do {
                        if let jsonData = data {
                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
                            successHandler(response, jsonObject as AnyObject)
                            
                            //print(jsonObject)
                        }else{
                            failureHandler(response, error!)
                        }
                    }catch let error {
                        failureHandler(response, error)
                        
                        print(error)
                    }
                }
                
            }).resume()
            
        } catch let error {
            print(error)
        }
        
    }
    
    
    class func getService(url: URL, _ successHandler: @escaping networkSuccessHandler, _ failureHandler: @escaping networkFailureHandler) -> Void {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data, response, error) in
            if let errorMessage = error {
                failureHandler(response, errorMessage)
                print(errorMessage)
            }else{
                do {
                    if let jsonData = data {
                        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                        successHandler(response, jsonObject as AnyObject)
                    }else {
                        failureHandler(response, error)
                    }
                } catch let error {
                    failureHandler(response, error)
                    print("Error is \(error)")
                }
            }
            
        }.resume()
    }

    
    //Checking for internet connection
        class func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    SCNetworkReachabilityCreateWithAddress(nil, $0)
                }
            }) else {
                return false
            }
            
            var flags: SCNetworkReachabilityFlags = []
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                return false
            }
            if flags.isEmpty {
                return false
            }
            
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            
            return (isReachable && !needsConnection)
        }
    
    
    
}
