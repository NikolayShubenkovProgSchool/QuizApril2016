//
//  QuiestionViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 09/04/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class QuiestionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var questionList:[Question]? {
        didSet {
            currentQuestion = questionList?.first
        }
    }
    var currentQuestion:Question? {
        didSet {
            updateViews()
        }
    }
    var answers:[String]? {
        return currentQuestion?.answers
    }
    var totalPoints = 0
    var currentQuestionIndex = 0
    
    //вызывается в момент, когда контроллер загрузил View. В этот момент лучше всего
    //начать загрузку данных для отображения
    override func viewDidLoad() {
        super.viewDidLoad()
        //отвечает за то, как и что показывать
        tableView.dataSource = self
        
        //отвечает за то, что делать, при возникновении различных событий 
        tableView.delegate = self
        
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
        
        let questionModels  = questionsToParse.map { element -> Question in
            
            let parsedModel = Question(json: element)
            return parsedModel
        }
        
        print("Похоже, что мы смогли получить модель!!! ИХААА!!\n\(questionModels)")
        questionList = questionModels
    }
    
    func updateViews(){
        //настроили изображение
        let image = currentQuestion?.image
        imageView.image = image
        
        //задали вопрос
        label.text = currentQuestion?.question
        
        //перезаполнить tableView
        tableView.reloadData()
    }
    
//    перед тем, как перейти на новый экран вызывается данный метод, где мы можем узнать 
//    куда именно идет переход, есть ли что-то внутри sender и т.д.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let newVC = segue.destinationViewController as? ResultViewController {
            newVC.result = sender as! Int
        }
        
//        if segue.identifier == "ShowResult" {
//            let newVC = segue.destinationViewController as! ResultViewController
//            newVC.result = sender as! Int
//        }
        
    }
}

extension QuiestionViewController:UITableViewDataSource {
    //answers
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        cell.textLabel?.text = answers?[indexPath.row]
        
        //нижний текст.
        let isCorrect = isAsnwerAtIndexIsCorrect(indexPath)
        
        cell.detailTextLabel?.text = isCorrect ? "Это правильный ответ" : "Не угадал(а)"
        
        return cell
    }
    
    func isAsnwerAtIndexIsCorrect(index:NSIndexPath)->Bool
    {
        return currentQuestion?.isCorrectAnswer(answers?[index.row]) ?? false
    }
}

extension QuiestionViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if isAsnwerAtIndexIsCorrect(indexPath){
            totalPoints += 1
        }
        
        currentQuestionIndex += 1
        
        guard currentQuestionIndex < questionList?.count else {
            print("Конец всему и даже викторине!")
            
            //0 do 1
            let rating = Double(totalPoints) / Double(questionList!.count)
            
            let convertedRating = Int(rating * 100)
            
            //выполнить переход на другой вьюконтроллер
            performSegueWithIdentifier("ShowResult", sender: convertedRating)
            
            return
        }
        
        currentQuestion = questionList?[currentQuestionIndex]
    }
    
}
































