//
//  BallView.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class BallView: UIView {
    
    private var type : Int? //类型0->选择，1->固定
    private var num : Int? //数字
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.red
        if type == 0{
            let handDrag = UIPanGestureRecognizer(target: self, action: #selector(funcDrag))
            self.addGestureRecognizer(handDrag)
        }
    }
    
    @objc func funcDrag(sender: UIPanGestureRecognizer){
        var Point = sender.translation(in: self.superview);//现对于起始点的移动位置
        Point = sender.location(in: self.superview);//在整个self.view 中的位置
        print("funDrag_"+String(describing: Point.x)+","+String(describing:Point.y))
        
        if(sender.state == .began){
            print("begin: "+String(describing: Point.x)+","+String(describing:Point.y))
        }else if(sender.state == .ended){
            print("ended: "+String(describing: Point.x)+","+String(describing:Point.y))
        }else{
            print("ing: "+String(describing: Point.x)+","+String(describing:Point.y))
        }
        self.frame = CGRect.init(x: Point.x - 35, y: Point.y - 35, width: 70, height: 70)
    }
    
    func setTypeAndNum(type:Int,num:Int) {
        self.type = type
        self.num = num
    }
}
