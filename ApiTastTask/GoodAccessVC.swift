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
import SDWebImage

class GoodAccessVC: UIViewController {
    
    var accessTokenDict: [String:String] = [:]
    var strToken = ""
    var textStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bearer = "Bearer "
        let accesToken = bearer + strToken
        accessTokenDict.updateValue(accesToken, forKey: "Authorization")
        print("GoodAccessVC pull token = \(accessTokenDict)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResaltScreen" {
            let vc = segue.destination as? ResultVC
            vc?.text = textStr
        }
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
                    print("text = \(self.textStr)")
                    self.performSegue(withIdentifier: "showResaltScreen", sender: nil)
                }
                else {
                    debugPrint("HTTP Request text failed: \(response.result.error)")
                }
        }
    }
    
    @IBAction func getTheText(_ sender: Any) {
        print("key = \(accessTokenDict)")
        sendRequestOnTheText(key: accessTokenDict)
    }
    
}
