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
import SDWebImage

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var name = ""
    var email = ""
    var password = ""
    
    struct SuccessData: Any {
        var success: Bool?
        var data: PulledData?
    }
    struct PulledData: Any {
        var uid : Int
        var name : String
        var email : String
        var access_token : String
        var role : Int
        var status : Int
        var created_at : Int
        var updated_at : Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name = nameTextField.text!
        email = emailTextField.text!
        password = passwordTextField.text!
    }
    
    func sendRequestRequest(name: String, email: String, password: String) {
        /**
         Request
         post http://apiecho.cf/api/signup/
         */
        
        // Add Headers
        let headers = [
            "Content-Type":"application/json; charset=utf-8",
            ]
        
        // JSON Body
        let body: [String : Any] = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        // Fetch Request
        Alamofire.request("http://apiecho.cf/api/signup/", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.description)")
                    //                    let swiftyJsonVar = JSON(response.result.value!) as? [String: Any]
                    //                    print("swiftyJsonVar = \(swiftyJsonVar)")
                    
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        name = nameTextField.text!
        print("name - \(nameTextField.text)")
        email = emailTextField.text!
        print("email - \(emailTextField.text)")
        password = passwordTextField.text!
        print("password - \(passwordTextField.text)")
        sendRequestRequest(name: name, email: email, password: password)
        
    }
}
