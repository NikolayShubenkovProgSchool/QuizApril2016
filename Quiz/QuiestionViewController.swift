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

        //попробуем представить json как коллекцию вида Строка -> любой объект
        guard let questionJSON = json as? [String:AnyObject],
            //если повезет, то считаем из questionJSON содержимое и
            //если это окажется массив, в котором лежат Коллекции вида String:Anyobject, то будем счастливы
              let questionsToParse = questionJSON["questions"] as? [ [String:AnyObject] ] else {
                print("fail to load dataModel")
                return
        }
        
        let questionModels  = questionsToParse.map { json -> Question in
            
            let parsedModel = Question(json: json)
            return parsedModel
        }
        
        print("Похоже, что мы смогли получить модель!!! ИХААА!!\n\(questionModels)")
        
    }
}




