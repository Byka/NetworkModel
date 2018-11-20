//
//  LoginViewController.swift
//  NetworkModel
//
//  Created by sbyka on 19/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit

class LoginViewController: NSObject {
    
    public class func login(_ url: URL,_ parameters: [String: String], _ successHandler: @escaping networkSuccessHandler, _ failureHandler: @escaping networkFailureHandler) -> Void {
        

        NetworkManager.post(url, parameters as AnyObject, { (response, data) in
            DispatchQueue.main.sync {
                if data is [String: Any] {
                    print(data)
                    let information = data as! [String: Any]
                    successHandler(response, information)
                } else{
                    print("No data availaible")
                }
            }
        }) { (response, error) in
            failureHandler(response, error)
        }
            
        
    }

}
