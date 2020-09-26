//
//  LogInViewController.swift
//  Twitter
//
//  Created by Anand Sai Mishra on 9/26/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "UserLoggedIn") == true{
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
   
    @IBAction func onLoginButton(_ sender: Any) {
        let requestTokenURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: requestTokenURL, success: {
            UserDefaults.standard.set(true, forKey: "UserLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Could Not Log In")
        })
        
    }
}
