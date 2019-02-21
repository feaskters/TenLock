//
//  CheckPointButton.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/20.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

//按钮代理
protocol CheckpointButtonProtocol {
    func CheckpointButtonClick(sender:CheckPointButton);
}

class CheckPointButton: UIButton {

    //代理
    var delegate:CheckpointButtonProtocol?
    
    /*配置按钮
     pragram :
     title : 按钮文字
     enable : 按钮是否可用
     */
    func setConfig(title: String, enable: Bool) {
        //设置文字
        self.setTitle(title, for: UIControl.State.normal)
        //设置背景和是否可点击
        if enable {
            self.isEnabled = true
            self.setBackgroundImage(UIImage.init(named: "checkPoint"), for: UIControl.State.normal)
        }else{
            self.isEnabled = false
            self.setBackgroundImage(UIImage.init(named: "checkPoint_gray"), for: UIControl.State.normal)
        }
        //设置文字样式
        self.titleLabel?.font = UIFont.init(name: "Marker Felt", size:  64.0)
        //添加点击事件
        self.addTarget(self, action: #selector(self.click(sender:)), for: UIControl.Event.touchUpInside)
    }
    
    //点击事件
    @objc func click(sender:UIButton) {
        Music.shared().musicPlayEffective()
        delegate?.CheckpointButtonClick(sender: self)
    }
    
}
