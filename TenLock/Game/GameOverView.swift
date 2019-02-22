//
//  GameOverView.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/22.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameOverView: UIView {

    private var resultArray : Array<UIImage> = Array<UIImage>.init()
    private var resultView : UIImageView = UIImageView.init()
    private let resultLabel = UILabel.init()
    private let resultIcon = UIImageView.init()
    
    func success(){
        //成功的动画
        for i in 0...11{
            let image = UIImage.init(named: "success" + String(i))
            self.resultArray.append(image!)
        }
        self.resultLabel.text = "success"
        self.resultLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        self.resultIcon.image = UIImage.init(named: "laugth")
        resultShow()
    }

    func fail() {
        //失败的动画
        for i in 0...11{
            let image = UIImage.init(named: "fail" + String(i))
            self.resultArray.append(image!)
        }
        self.resultLabel.text = "fail"
        self.resultLabel.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        self.resultIcon.image = UIImage.init(named: "calm")
        resultShow()
    }
    
    //显示结果
    private func resultShow(){
        //显示帧动画
        self.resultView.animationImages = self.resultArray
        self.resultView.animationDuration = 1.5
        self.resultView.frame = CGRect.init(x: (self.frame.width - 300) / 2, y: (self.frame.height - 400) / 2, width: 300, height: 300)
        self.addSubview(self.resultView)
        self.resultView.animationRepeatCount = 1
        self.resultView.startAnimating()
        
        self.isUserInteractionEnabled = false
        
        //显示结果
        resultLabel.alpha = 0
        resultLabel.frame = CGRect.init(x: (self.frame.width - 300) / 2, y: (self.frame.height - 100) / 2, width: 300, height: 300)
        resultLabel.textAlignment = NSTextAlignment.center
        resultLabel.font = UIFont.init(name: "Marker Felt", size:100)
        
        //显示结果图标
        resultIcon.alpha = 0
        resultIcon.frame = resultView.frame
        
        self.addSubview(resultIcon)
        self.addSubview(resultLabel)
        //动画
        UIView.animate(withDuration: 1.5, animations: {
            self.resultLabel.alpha = 1
            self.resultIcon.alpha = 1
        }) { (Bool) in
            if Bool {
                self.isUserInteractionEnabled = true
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Music.shared().musicPlayEffective()
        self.parentViewController()?.dismiss(animated: false, completion: nil)
    }
    
    //获取viewcontroller
    func parentViewController() -> UIViewController? {
        
        var n = self.next
        
        while n != nil {
            
            if (n is UIViewController) {
                
                return n as? UIViewController
            }
            
            n = n?.next
        }
        
        return nil
    }
    
}
