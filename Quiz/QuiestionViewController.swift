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
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
    
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
    
    
    //MARK: - View Controller Life Cycle -
    
//    Инициализация вызывается при инициализации из Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//  2. Загрузка View.
//    Если вы хотите создать все view из кода,
//  то в нем вы их создаете, как-то друг на друга накидываете,
//  и настраиваете
//  Если ViewController был описан через StoryBorad, то этот
//  переопределять не нужно.
//    override func loadView() {
//        
//    }
    
    
//   3. Вызывается в момент, когда все Views вашего контроллера
//   уже загружены
//   В этот момент вью контроллер еще не присутствует на экране
//   Это отличное место для инициализации данных, запуска каких-то длительных процессов
//   В этот момент ваши Views еще не приняли конечных положений
//   Этот метод вызывается один раз за время работы вашего контроллера
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad() - вызывается в момент, когда контроллер загрузил View. В этот момент лучше всего начать загрузку данных для отображения. ")
        //отвечает за то, как и что показывать
        tableView.dataSource = self
        
        //отвечает за то, что делать, при возникновении различных событий 
        tableView.delegate = self
        
        loadData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        currentQuestionIndex = 0
        totalPoints = 0
        currentQuestion = questionList?.first
        print(" - viewWillAppear Вызывается перед самым появлением на экране устройства. Может вызываться несколько раз за время жизни вашего контроллера")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(" - viewDidAppear. Отличное место для того, чтобы запустить анимацию. ")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("- viewWillDisappear. Ваш контроллер начинает исчезать с экрана")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("- viewDidDisappear. Контроллер полностью исчез с экрана")
    }
    
    deinit {
        print(" - deinit. Сейчас на Земле станет на один ViewController меньше ((")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(" - didReceiveMemoryWarning Паника-паника. У устройства кончается память. Нужно срочно избавить от всех неиспользуемых ресурсов")
    }
    
    //MARK: - Setup
    
    func loadData(){
        
        let fileName = "cinema"
        let fileExtention = "json"
        
        //запросить у Bundle (хранилище файлов, поставляемое с приложением) конкретный файл
        let pathToVictorineFile = NSBundle.mainBundle().pathForResource(fileName,
                                                                    ofType: fileExtention)!
        //считаем данные из файла. В объекте data будут лежать какие-то байты с информацией, но
        //кроме того, что они там лежат ничего не известно.
        let data = NSData(contentsOfFile: pathToVictorineFile)!
        
        // ! означает, что я гарантирую, что данные получится преобразовать
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
        

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
        
        questionList = questionModels
    }
    
    func updateViews(){
        updateImage()
        //задали вопрос
        label.text = currentQuestion?.question
        
        //перезаполнить tableView
        tableView.reloadData()
    }
    
    func updateImage(){
        //1.уменьшим высоту картинки до нуля
        UIView.animateWithDuration(0.5, animations: {
            self.imageHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
            
            }) { _ in
                
                //2.заменим изобаржение
                let image = self.currentQuestion?.image
                self.imageView.image = image
                
                
                //3.растянем картинку обратно с помощью новой анимации
                UIView.animateWithDuration(2,
                                           delay: 0,
                                           usingSpringWithDamping: 0.3,//0 - очень сильно колбасит струну. 1 - без колебаний
                                           initialSpringVelocity: 7,//относительная начальная скорость изменения параметров
                                           options: [],
                                           animations: { 
                                            self.imageHeightConstraint.constant = 180
                                            self.view.layoutIfNeeded()
                    },
                                           completion: nil)
                
        }
        
        
        
    }
    
    //MARK: -
    
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

//MARK: - UITableViewDataSource

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

//MARK: - UITableViewDelegate

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
































