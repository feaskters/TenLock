//
//  CheckPointButton.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/20.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class CheckPointButton: UIButton {

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
            self.backgroundColor = UIColor.green
        }else{
            self.isEnabled = false
            self.backgroundColor = UIColor.red
        }
        //设置文字样式
        self.titleLabel?.font = UIFont.init(name: "Marker Felt", size:  64.0)
    }
}
