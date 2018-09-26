//
//  ResultVC.swift
//  ApiTastTask
//
//  Created by Nikita Nechyporenko on 25.09.2018.
//  Copyright © 2018 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var text = ""
    //    var sortedArr: [Character] = []
    var dictChar: [String: Int] = [:]
    var arrSimbols: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterCounting(text: text)
        let dictToString = (dictChar.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: ";")
        print("string = \(dictToString)")
        arrSimbols = dictToString.components(separatedBy: ";").sorted {$0 < $1}
        
        print("string = \(arrSimbols)")
    }
    
    func characterCounting(text: String) {
        let textArr = Array(text)
        var sortedArr = textArr.sorted {$0 < $1}
        var key = ""
        var value = 0
        print("sorted = \(sortedArr)")
        for _ in 0..<sortedArr.count {
            let firstSimbol = sortedArr.removeFirst()
            if key != "" {
                if firstSimbol == Character(key) {
                    key = String(firstSimbol)
                    value += 1
                }
                else {
                    dictChar.updateValue(value, forKey: key)
                    key = ""
                    value = 0
                }
            }
            if key == "" {
                key = String(firstSimbol)
                value += 1
            }
        }
        dictChar.updateValue(value, forKey: key)
    }
}

extension ResultVC: UITableViewDataSource {
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSimbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellResult = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cellResult.textLabel?.text = arrSimbols[indexPath.row]
        return cellResult
    }
}

