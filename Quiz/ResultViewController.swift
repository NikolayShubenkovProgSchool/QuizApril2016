//
//  ResultViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 09/04/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var result = 0 {//from 0 to 100
        didSet {
            switch result {
                
            case Int.min ..< 0:
                result = 0
                
            case 101 ..< Int.max :
                result = 100
            
            default:
                return
            }
        }
    }
    
    @IBOutlet weak var resultLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    func updateViews() {
        var text = ""
        switch result {
        case 0:
            text = "Вы бот"
        case 1 ... 30:
            text = "Слабовато"
        case 31 ..< 55:
            text = "Неплохо, но могло быть и луше"
        case 56 ... 99:
            text = "Отлично"
        case 100:
            text = "Вот теперь точно бот!"
        default: print("Не учтено значение рейтинга \(text)")
            text = "Ошибка. Ай-ай-ай"
        }
        resultLable.text = text
    }
}
