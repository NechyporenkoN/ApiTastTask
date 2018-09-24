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

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
        
        email = emailTextField.text!
        password = passwordTextField.text!
        
    }

    
    @IBAction func buttonSignIn(_ sender: Any) {
        
}
}
