//
//  GoodAccessVC.swift
//  ApiTastTask
//
//  Created by Nikita Nechyporenko on 25.09.2018.
//  Copyright © 2018 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class GoodAccessVC: UIViewController {
    
    var accessTokenDict: [String:String] = [:]
    var strToken = ""
    var textStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createdAccessToken()
    }
    
    func createdAccessToken() {
        let bearer = "Bearer "
        let accesToken = bearer + strToken
        accessTokenDict.updateValue(accesToken, forKey: "Authorization")
    }
    
    func sendRequestOnTheText(key: [String:String]) {
        // Add Headers
        let headers = key
        
        // Fetch Request
        Alamofire.request("http://apiecho.cf/api/get/text/", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let Json = JSON(response.data!)
                    let text = Json["data"].string
                    self.textStr = text!
                    self.performSegue(withIdentifier: "showResultScreen", sender: nil)
                } else {
                    debugPrint("HTTP Request text failed: \(String(describing: response.result.error))")
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultScreen" {
            let vc = segue.destination as? ResultVC
            vc?.text = textStr
        }
    }
    
    @IBAction func getTheText(_ sender: Any) {
        sendRequestOnTheText(key: accessTokenDict)
    }
}
