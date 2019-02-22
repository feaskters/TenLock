//
//  GameSelectorViewController.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/20.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameSelectorViewController: UIViewController , CheckpointButtonProtocol {
    
    @IBOutlet weak var checkpointScrollView: UIScrollView!
    private var checkPointButtons : Array<CheckPointButton> = Array.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidLayoutSubviews() {
        if self.checkPointButtons.count <= 0 {
            let sc_width = self.checkpointScrollView.frame.width //scrollView宽度
            let btn_width : CGFloat = 100 //按钮宽度
            let space : CGFloat = (sc_width - btn_width * 3) / 4 //按钮间距
            let count = Checkpoints.shared().checkPointsArray.count //按钮数量
            //设置scrollview的contentsize
            self.checkpointScrollView.contentSize = CGSize.init(width: self.checkpointScrollView.bounds.width , height: CGFloat(count) * (btn_width + space) / 3)
            //添加按钮
            for i in 0...count - 1  {
                //初始化按钮
                let x : CGFloat = CGFloat(i % 3) * (btn_width + space) + space
                let y : CGFloat = CGFloat(i / 3) * (btn_width + space) + space
                let checkpoint = CheckPointButton.init(frame: CGRect.init(x: x, y: y, width: btn_width, height: btn_width))
                //设置按钮代理
                checkpoint.delegate = self
                checkpoint.tag = i
                checkpoint.setConfig(title: String(i + 1), enable: (Checkpoints.shared().checkPointsArray[i] as! Dictionary<String, Any>)["enable"] as! Bool)
                self.checkpointScrollView.addSubview(checkpoint)
                self.checkPointButtons.append(checkpoint)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.checkPointButtons.count != 0 {
            //刷新按钮状态
            for item in 0...self.checkPointButtons.count - 1{
                self.checkPointButtons[item].setConfig(title: String(item + 1),enable: (Checkpoints.shared().checkPointsArray[item] as! Dictionary<String, Any>)["enable"] as! Bool)
            }
        }
    }

    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        self.dismiss(animated: true, completion: nil)
    }
    
    //实现按钮代理协议
    func CheckpointButtonClick(sender: CheckPointButton) {
        let gvc = GameViewController.init(nibName: nil, bundle: nil)
        gvc.checkpointInfo = Checkpoints.shared().checkPointsArray[sender.tag] as? Dictionary<String, Any>
        gvc.level = String(sender.tag + 1)
        self.present(gvc, animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
