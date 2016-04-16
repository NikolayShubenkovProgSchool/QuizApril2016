//
//  AnimationDemoViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 16/04/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class AnimationDemoViewController: UIViewController {

    @IBOutlet weak var astalavistaCenterX: NSLayoutConstraint!
    @IBOutlet weak var vandamToGreetingSpace: NSLayoutConstraint!
    @IBOutlet weak var firstYellowView: UIView!
    
    @IBOutlet weak var vandamView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      Простая анимация доступна для следующих параметров у UIView и его наследников:
//        1. alpha - прозрачность
//        2. Положение вьюхи и ее размер
//        3. цвет фона
//        4. tranasform - специальная структура, которая определяет положение, вращение у вьюхи и масштаб. Осторжно используйте ее с AutoLayout потому, что они не всегда друг с другом ладят
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        prepareForAnimation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animateAppearing()
    }
    
//  MARK: - Animation
    
    func prepareForAnimation(){
        vandamView.alpha = 0
        firstYellowView.backgroundColor = UIColor.greenColor()
        vandamToGreetingSpace.constant  = -40
        astalavistaCenterX.constant     = view.bounds.width
    }
    
    func animateAppearing(){
        UIView.animateWithDuration(0.3) { 
            self.vandamView.alpha = 1
            self.firstYellowView.backgroundColor = UIColor.yellowColor()
            self.vandamToGreetingSpace.constant  = 20
            self.astalavistaCenterX.constant     = 0
            
            //Если вы меняете какие-либо Constrints
            //То обязательно после их изменения вызовите этот метод
            self.view.layoutIfNeeded()
        }
    }

}
