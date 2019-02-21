//
//  GameViewController.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var title_label: UILabel!
    var level :String?
    var checkpointInfo : Dictionary<String, Any>?
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var selectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title_label.text = "Level " + (level ?? "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let selX = self.selectView.frame.origin.x
        let selY = self.selectView.frame.origin.y
        print(self.selectView.frame)
        let selWidth = selectView.frame.width
        let space :CGFloat = (selWidth - 70 * 4) / 5
        var count :Int = 0
        
        for item in (checkpointInfo!["balls_select"] as! Array<Any>) {
            
            let x :CGFloat = ( 70 + space ) * CGFloat( count % 4 ) + space + selX
            let y :CGFloat = ( 70 + space ) * CGFloat( count / 4 ) + space + selY
            //布置底部按钮
            let frame = CGRect.init(x:x, y: y, width: 70, height: 70)
            let ball = BallView(frame: frame)
            ball.setTypeAndNum(type: 0, num: item as! Int)
            self.containerView.addSubview(ball)
            count += 1
        }
        
    }
    
    //返回
    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        self.dismiss(animated: false, completion: nil)
    }
}
