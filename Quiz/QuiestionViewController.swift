//
//  QuiestionViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 09/04/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class QuiestionViewController: UIViewController {

    //вызывается в момент, когда контроллер загрузил View. В этот момент лучше всего
    //начать загрузку данных для отображения
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }

    func loadData(){
        
        let fileName = "cinema"
        let fileExtention = "json"
        
        //запросить у Bundle (хранилище файлов, поставляемое с приложением) конкретный файл
        let pathToVictorineFile = NSBundle.mainBundle().pathForResource(fileName,
                                                                    ofType: fileExtention)!
        //считаем данные из файла. В объекте data будут лежать какие-то байты с информацией, но
        //кроме того, что они там лежат ничего не известно.
        let data = NSData(contentsOfFile: pathToVictorineFile)!
        
        print(data)
        
        // ! означает, что я гарантирую, что данные получится преобразовать
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
        
        print("содержимое викторины:\(json)")
    }
}
