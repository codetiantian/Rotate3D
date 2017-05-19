//
//  ViewController.swift
//  Rotate3D
//
//  Created by 这个夏天有点冷 on 2017/5/19.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var angle = CGPoint.init(x: 0, y: 0)
    
    let diceView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addDice()
        
        let panGes = UIPanGestureRecognizer.init(target: self, action: #selector(viewTransform))
        diceView.addGestureRecognizer(panGes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//  创建3D筛子模型
extension ViewController {
    fileprivate func addDice() {
        let viewFrame = UIScreen.main.bounds
        let imageViewWH : CGFloat = 100
        
        var diceTransform = CATransform3DIdentity
        
        diceView.frame = CGRect.init(x: 0, y: viewFrame.maxY / 2 - imageViewWH / 2, width: viewFrame.width, height: imageViewWH)
        
        //  1
        let dice1 = UIImageView.init(image: UIImage.init(named: "dice1.jpg"))
        dice1.frame = CGRect.init(x: viewFrame.maxX / 2 - imageViewWH / 2, y: 0, width: imageViewWH, height: imageViewWH)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, imageViewWH / 2)
        dice1.layer.transform = diceTransform
        
        //6
        let dice6 = UIImageView.init(image: UIImage(named: "dice6.jpg"))
        dice6.frame = CGRect(x: viewFrame.maxX / 2 - imageViewWH / 2, y: 0, width: imageViewWH, height: imageViewWH)
        diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -imageViewWH / 2)
        dice6.layer.transform = diceTransform
        
        //  2
        let dice2 = UIImageView.init(image: UIImage.init(named: "dice2.jpg"))
        dice2.frame = CGRect(x: viewFrame.maxX / 2 - imageViewWH / 2, y: 0, width: imageViewWH, height: imageViewWH)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, imageViewWH / 2)
        dice2.layer.transform = diceTransform
        
        //  5
        let dice5 = UIImageView.init(image: UIImage(named: "dice5.jpg"))
        dice5.frame = CGRect(x: viewFrame.maxX / 2 - imageViewWH / 2, y: 0, width: imageViewWH, height: imageViewWH)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, imageViewWH / 2)
        dice5.layer.transform = diceTransform
        
        //  3
        let dice3 = UIImageView.init(image: UIImage(named: "dice3.jpg"))
        dice3.frame = CGRect(x: viewFrame.maxX / 2 - imageViewWH / 2, y: 0, width: imageViewWH, height: imageViewWH)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, imageViewWH / 2)
        dice3.layer.transform = diceTransform
        
        //4
        let dice4 = UIImageView.init(image: UIImage(named: "dice4.jpg"))
        dice4.frame = CGRect(x: viewFrame.maxX / 2 - imageViewWH / 2, y: 0, width: imageViewWH, height: imageViewWH)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, imageViewWH / 2)
        dice4.layer.transform = diceTransform
        
        diceView.addSubview(dice1)
        diceView.addSubview(dice2)
        diceView.addSubview(dice3)
        diceView.addSubview(dice4)
        diceView.addSubview(dice5)
        diceView.addSubview(dice6)
        view.addSubview(diceView)
    }
}

//  创建3D模型
extension ViewController {
    @objc fileprivate func viewTransform(sender : UIPanGestureRecognizer) {
        
        let point = sender.translation(in: diceView)
        let angleX = self.angle.x + (point.x / 30)
        let angleY = self.angle.y - (point.y / 30)
        
        var transform = CATransform3DIdentity
        
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        diceView.layer.sublayerTransform = transform
        
        if sender.state == .ended {
            self.angle.x = angleX
            self.angle.y = angleY
        }
    }
}
