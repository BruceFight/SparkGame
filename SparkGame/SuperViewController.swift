//
//  SuperViewController.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/18.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func becomeActive() -> () {
        let orientationTarget = NSNumber.init(value: (UIInterfaceOrientation.landscapeLeft).hashValue)
        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.landscapeLeft , UIInterfaceOrientationMask.landscapeRight]
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

}
