//
//  SignUpVC.swift
//  ApiTastTask
//
//  Created by Nikita Nechyporenko on 24.09.2018.
//  Copyright © 2018 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var name = ""
    var email = ""
    var password = ""
    var tokenStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name = nameTextField.text!
        email = emailTextField.text!
        password = passwordTextField.text!
    }
    
    func sendRequestRequest(name: String, email: String, password: String) {
        // JSON Body
        let body: [String : Any] = [
            "name": name,
            "email": email,
            "password": password
        ]
        // Fetch Request
        Alamofire.request("http://apiecho.cf/api/signup/", method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let swiftyJson = JSON(response.data!)
                    let token = swiftyJson["data"]["access_token"].string
                    self.tokenStr = token!
                    self.performSegue(withIdentifier: "goodSignUp", sender: nil)
                }
                else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goodSignUp" {
            let vc = segue.destination as? GoodAccessVC
            vc?.strToken = tokenStr
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        name = nameTextField.text!
        email = emailTextField.text!
        password = passwordTextField.text!
        print("name \(name), email \(email), password \(password)")
        sendRequestRequest(name: name, email: email, password: password)
    }
}
