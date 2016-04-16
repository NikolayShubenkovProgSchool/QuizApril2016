//
//  AnimationDemoViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 16/04/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class AnimationDemoViewController: UIViewController {

    @IBOutlet weak var watchInCinemaCenterX: NSLayoutConstraint!
    @IBOutlet weak var watchLaterLabel: UILabel!
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
        watchInCinemaCenterX.constant   = view.bounds.width
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
        
//        UIViewAnimationOptions.CurveEaseInOut  --  плавно начать и плавно закончить
//        UIViewAnimationOptions.CurveEaseIn --  начинается плавно, но быстро заканчивается
        
        
        UIView.animateWithDuration(0.3,
                                   delay: 0,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: { 
                                    self.watchInCinemaCenterX.constant = -10
                                    self.view.layoutIfNeeded()
        }) { a in
//            этот параметр, который передается в конце анимации 
//            означает завершилась ли вызывающая анимация или нет.
//                по завершении этого блока анимации будет вызвана другая анимация
                UIView.animateWithDuration(0.5,
                                           delay: 0,
                                           options: [.Repeat,.Autoreverse], animations: {
                                            self.watchInCinemaCenterX.constant = 15
                                            self.watchLaterLabel.textColor = UIColor.greenColor()
                                            self.view.layoutIfNeeded()
                    }, completion: nil)
        }
        
    }

}
