//
//  GameSelectorViewController.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/20.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameSelectorViewController: UIViewController {
    @IBOutlet weak var checkpointScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let sc_width = self.checkpointScrollView.frame.width //scrollView宽度
        let btn_width : CGFloat = 100 //按钮宽度
        let space : CGFloat = 10 //按钮间距
        let count = 30 //按钮数量
        //设置scrollview的contentsize
        self.checkpointScrollView.contentSize = CGSize.init(width: self.checkpointScrollView.bounds.width , height: CGFloat(count) * (btn_width + space))
        //添加按钮
        for i in 0...count - 1  {
            //初始化按钮
            let x : CGFloat = CGFloat(i % 3) * (btn_width + space) + space
            let y : CGFloat = CGFloat(i / 3) * (btn_width + space) + space
            let checkpoint = CheckPointButton.init(frame: CGRect.init(x: x, y: y, width: btn_width, height: btn_width))
            checkpoint.setConfig(title: String(i + 1), enable: true)
            self.checkpointScrollView.addSubview(checkpoint)
        }
        
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
