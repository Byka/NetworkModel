//
//  ViewController.swift
//  NetworkModel
//
//  Created by sbyka on 19/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //http://vtsosonlinemobile.pcctg.net/Service1.svc/Login/
    
    //Peramaters
    //
    
//    {
//    "username": "kpavan",
//    "password": "kpavan"
//    }
    
    @IBAction func callPostServiceAction(_ sender: Any) {
        let userDetails : [String : String] = ["username": "kpavan", "password": "kpavan"]
        
        /*
        let url: URL! = NSURL(string: "http://vtsosonlinemobile.pcctg.net/Service1.svc/Login/") as! URL
        
        LoginViewController.login(userDetails, { (response, data) in
            let results = data as! [String: AnyObject]
            print("LOGIN RESULTS \(results)")

        }){ (response, error) in
            print(error)
            
        }
        */
        
        let getURL : URL! = NSURL(string: "https://jsonplaceholder.typicode.com/posts/1")! as URL
        
        NetworkManager.getService(url: getURL, { (response, data) in
            let results = data as! [String: AnyObject]
            
            print(results)
        }, { (response, error) in
            
            print(error)
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

