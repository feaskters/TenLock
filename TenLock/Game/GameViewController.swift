//
//  GameViewController.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/21.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,BallProtocol {

    @IBOutlet weak var title_label: UILabel!
    var level :String?
    var checkpointInfo : Dictionary<String, Any>?
    var ballArray : Array<BallView>?
    var lineArray : Array<Array<Any>>?
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var selectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if getCurrentLanguage() == "cn"{
            self.title_label.text = "等级 " + (level ?? "")
        }else{
            self.title_label.text = "Level " + (level ?? "")
        }
    }
    
    //获取系统语言
    func getCurrentLanguage() -> String {
        //        let defs = UserDefaults.standard
        //        let languages = defs.object(forKey: "AppleLanguages")
        //        let preferredLang = (languages! as AnyObject).object(0)
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        //        let preferredLang = (languages! as AnyObject).object(0)
        
        switch String(describing: preferredLang) {
        case "en-US", "en-CN":
            return "en"//英文
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "cn"//中文
        default:
            return "en"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.ballArray = Array.init()
        self.lineArray = Array.init()
        
        let selX = self.selectView.frame.origin.x
        let selY = self.selectView.frame.origin.y
        let selWidth = selectView.frame.width
        let space :CGFloat = (selWidth - 70 * 4) / 5
        var count :Int = 0
        
        let mainX = self.mainView.frame.origin.x
        let mainY = self.mainView.frame.origin.y
        let mainWidth = self.mainView.frame.width
        let mainHeight = self.mainView.frame.height
        
        //初始化背景
        let mainBackground = UIImageView.init(image: UIImage.init(named: level!))
        mainBackground.frame = CGRect.init(x: 0, y: 0, width: 340, height: 340)
        self.mainView.addSubview(mainBackground)
        
        //固定按钮
        for item in (checkpointInfo!["balls"] as! Array<Any>) {
            
            let position :Dictionary<String,Any> = (item as! Dictionary<String,Any>)["position"]! as! Dictionary<String, Any>
            let x : CGFloat = mainX + mainWidth * CGFloat(Double(position["x"]! as! String)!) - 35
            let y : CGFloat = mainY + mainHeight * CGFloat(Double(position["y"]! as! String)!) - 35
            //布置按钮
            let frame = CGRect.init(x:x, y: y, width: 70, height: 70)
            let ball = BallView(frame: frame)
            ball.setTypeAndNum(type: 1, num: (item as! Dictionary<String,Any>)["number"] as! Int)
            self.containerView.addSubview(ball)
            
            //加入数组
            self.ballArray?.append(ball)
        }
        
        //可选择按钮
        for item in (checkpointInfo!["balls_select"] as! Array<Any>) {
            
            let x :CGFloat = ( 70 + space ) * CGFloat( count % 4 ) + space + selX
            let y :CGFloat = ( 70 + space ) * CGFloat( count / 4 ) + space + selY
            //布置底部按钮
            let frame = CGRect.init(x:x, y: y, width: 70, height: 70)
            let ball = BallView(frame: frame)
            ball.setTypeAndNum(type: 0, num: item as! Int)
            ball.delegate = self
            self.containerView.addSubview(ball)
            count += 1
        }
        
       //线条
        for item in (checkpointInfo!["lines"] as! Array<Array<Any>>){
            self.lineArray?.append(item)
        }
        
    }
    
    //返回
    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        self.dismiss(animated: false, completion: nil)
    }
    
    //小球代理
    func ballIsInHole(x: CGFloat, y: CGFloat, sender:BallView) -> Dictionary<String, CGFloat> {
        var dic = Dictionary<String, CGFloat>.init()
        dic["isHole"] = CGFloat(-1)
        dic["x"] = CGFloat(0)
        dic["y"] = CGFloat(0)

        for item in ballArray! {
            if item.num! == 0 {
                if x >= item.beginX! && x <= item.beginX! + 70 && y >= item.beginY! && y <= item.beginY! + 70{
                    dic["isHole"] = CGFloat(1)
                    dic["x"] = item.beginX!
                    dic["y"] = item.beginY!
                    item.num = sender.num!
                    sender.isUserInteractionEnabled = false
                }
            }
        }
        if self.judgePulsTen() {
            for item in ballArray!{
                if item.num! == 0 {
                    return dic
                }
            }
            //成功
            //修改plist
            Checkpoints.shared().success(withLevel: Int32(self.level!)!)
            //显示成功动画
            let gov = GameOverView.init(frame: self.view.frame)
            self.view.addSubview(gov)
            gov.success()
            
        }else{
            for item in ballArray!{
                if item.num! == 0 {
                    return dic
                }
            }
            //失败
            let gov = GameOverView.init(frame: self.view.frame)
            self.view.addSubview(gov)
            gov.fail()
        }
        return dic
    }
    
    //判断相加是否为10
    func judgePulsTen() -> Bool {
        for item in lineArray! {
            var sum = 0
            for i in item{
                sum = sum + self.ballArray![(i as! Int)].num!
            }
            if sum != 10{
                return false
            }
        }
        return true
    }
}
