//
//  BallView.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

protocol BallProtocol {
    func ballIsInHole(x:CGFloat , y:CGFloat ,sender:BallView) -> Dictionary<String,CGFloat>;
}

class BallView: UIView {
    
    private var type : Int? //类型0->选择，1->固定
    var num : Int? //数字
    var beginX : CGFloat?
    var beginY : CGFloat?
    var delegate : BallProtocol?
    
    override func layoutSubviews() {
       
        if type == 0{
            let handDrag = UIPanGestureRecognizer(target: self, action: #selector(funcDrag))
            self.addGestureRecognizer(handDrag)
            let name = "ball" + String(arc4random() % 5)
            let imageview = UIImageView.init(image: UIImage.init(named: name))
            imageview.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            self.addSubview(imageview)
        }else{
            if self.num == 0 {
                let imageview = UIImageView.init(image: UIImage.init(named: "hole"))
                imageview.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                self.addSubview(imageview)
            }else{
                let name = "ball" + String(arc4random() % 5)
                let imageview = UIImageView.init(image: UIImage.init(named: name))
                imageview.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                self.addSubview(imageview)
            }
        }
        //设置初始位置
        self.beginX = self.frame.origin.x
        self.beginY = self.frame.origin.y
        
        //设置数字
        if self.num != 0 {
            let label = UILabel.init()
            label.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            label.text = String(num!)
            label.textColor = UIColor.white
            label.font = UIFont.init(name: "Marker Felt", size: 36)
            label.textAlignment = NSTextAlignment.center
            self.addSubview(label)
        }
        
       
    }
    
    @objc func funcDrag(sender: UIPanGestureRecognizer){
        var Point = sender.translation(in: self.superview);//现对于起始点的移动位置
        Point = sender.location(in: self.superview);//在整个self.view 中的位置
      
        if(sender.state == .began){
            Music.shared().musicPlayEffective()
//            print("begin: "+String(describing: Point.x)+","+String(describing:Point.y))
        }else if(sender.state == .ended){
            Music.shared().musicPlayEffective()
//            print("ended: "+String(describing: Point.x)+","+String(describing:Point.y))
            let dic = delegate?.ballIsInHole(x: Point.x, y: Point.y, sender:self)
            if dic!["isHole"]! < CGFloat(0){
                self.frame = CGRect.init(x: self.beginX! , y: self.beginY!, width: 70, height: 70)
            }else{
                self.frame = CGRect.init(x: dic!["x"]! , y: dic!["y"]!, width: 70, height: 70)
            }
        }else{
//            print("ing: "+String(describing: Point.x)+","+String(describing:Point.y))
            self.frame = CGRect.init(x: Point.x - 35, y: Point.y - 35, width: 70, height: 70)
        }
        
    }
    
    func setTypeAndNum(type:Int,num:Int) {
        self.type = type
        self.num = num
    }
}
