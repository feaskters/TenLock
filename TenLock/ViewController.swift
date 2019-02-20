//
//  ViewController.swift
//  TenLock
//
//  Created by iOS123 on 2019/2/20.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func start(_ sender: UIButton) {
        let gsvc = GameSelectorViewController.init(nibName: nil, bundle: nil)
    self.present(gsvc, animated: true, completion: nil)
    }
    
    @IBAction func setting(_ sender: UIButton) {
    }
}

