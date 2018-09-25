//
//  ResultVC.swift
//  ApiTastTask
//
//  Created by Nikita Nechyporenko on 25.09.2018.
//  Copyright © 2018 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet weak var resultText: UITextView!
    
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultText.text = text
    }

    }
   

