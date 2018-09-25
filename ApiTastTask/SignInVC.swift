//
//  SignInVC.swift
//  ApiTastTask
//
//  Created by Nikita Nechyporenko on 24.09.2018.
//  Copyright © 2018 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var email = ""
    var password = ""
    var tokenStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email = emailTextField.text!
        password = passwordTextField.text!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGoodAccess" {
            let vc = segue.destination as? GoodAccessVC
            vc?.strToken = tokenStr
        }
    }
    
    
    func sendRequestForSignIn(email: String, password: String) {
        // JSON Body
        let body: [String : Any] = [
            "email": email,
            "password": password
        ]
        // Fetch Request
        Alamofire.request("http://apiecho.cf/api/login/", method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let swiftyJson = JSON(response.data!)
                    let token = swiftyJson["data"]["access_token"].string
                    self.tokenStr = token!
                    self.performSegue(withIdentifier: "showGoodAccess", sender: nil)
                }
                else {
                    debugPrint("HTTP Request Log in failed: \(response.result.error)")
                }
        }
    }
    
    @IBAction func buttonSignIn(_ sender: Any) {
        email = emailTextField.text!
        password = passwordTextField.text!
        sendRequestForSignIn(email: email, password: password)
    }
}

