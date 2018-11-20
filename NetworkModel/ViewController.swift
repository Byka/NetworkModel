//
//  ViewController.swift
//  NetworkModel
//
//  Created by sbyka on 19/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func callGetServiceAction(_ sender: Any) {
        
        guard NetworkManager.isConnectedToNetwork() else {
            alertMessage(response: "Net connection not available")
            return
        }
        
        let getURL : URL! = NSURL(string: "https://jsonplaceholder.typicode.com/posts/1")! as URL
        
        NetworkManager.getService(url: getURL, { (response, data) in
            let results = data as! [String: AnyObject]
            
            print(results)
        }, { (response, error) in
            
            print(error)
        })
        
    }
    
    
    
    @IBOutlet weak var netConnectionView: UIView!
    @IBAction func postServiceAction(_ sender: Any) {
        
        let url: URL = NSURL(string: "https://jsonplaceholder.typicode.com/posts?userId=1") as! URL
        let userDetails : [String : String] = ["xxxxx": "xxxxx", "xxxx": "xxxxx"]

        
        guard NetworkManager.isConnectedToNetwork() else {
            alertMessage(response: "Net connection not available")
            return
        }
        
        LoginViewController.login(url, userDetails, { (response, data) in
            let results = data as! [String: AnyObject]
            print("LOGIN RESULTS \(results)")
            
        }){ (response, error) in
           
            print(error)
            
        }
  
        
    }
    
    
    
    func alertMessage(response: String) {
    
        let alert = UIAlertController(title: "Net connection not available", message: "", preferredStyle: .alert)
        let defaultAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true)
        
    }
    
    
    
    @IBAction func checkInterNetConnection(_ sender: Any) {
        let connection :Bool = NetworkManager.isConnectedToNetwork()
        print(connection)
        
        if NetworkManager.isConnectedToNetwork() {
            self.netConnectionView.backgroundColor = UIColor.green
        }else {
            self.netConnectionView.backgroundColor = UIColor.red
        }
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

