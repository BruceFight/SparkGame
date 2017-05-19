//
//  ViewController.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/17.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: SuperViewController,UITextFieldDelegate {

    var mainSKView = JBMainSKView()
    var logView    = JBLogMainView()
    var resetView  = JBLogResetView()
    var backBtn    = UIButton()

    fileprivate var keyBoardHeight : CGFloat = 0
    fileprivate var kIfKeyboardShowed : Bool = false
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigures()
        addObserverForKeyBoard()
    }
    
    func setConfigures() -> () {
        //@ mainSKView
        mainSKView = JBMainSKView.init(frame: self.view.bounds)
        self.view.addSubview(mainSKView)
        
        //@ LogView
        logView = JBLogMainView.init(frame: CGRect.init(x: (self.view.bounds.width-600)/2, y: (self.view.bounds.size.height-500)/2, width: 600, height: 500))
        UIView.animate(withDuration: 0.2, animations: {
            self.logView.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                self.logView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
        }
        logView.centerBtnTouchHandler = { [weak self](btn,hash) in
            print(" >>>>>>>>>> 💕\(btn.tag)")
            switch btn.tag {
            case hash >> 1://Login
                
                break
            case hash >> 2://Remember
                
                break
            case hash >> 3://Forget
                self?.logView.nameTextField.resignFirstResponder()
                self?.logView.secretTextField.resignFirstResponder()
                self?.logView.isHidden = true
                self?.logView.leftEmmiterNode.particleBirthRate = 0
                self?.logView.rightEmmiterNode.particleBirthRate = 0
                self?.resetView.isHidden = false
                self?.backBtn.isHidden = false
                break
            default:break
            }
        }
        self.view.addSubview(logView)
        
        
        resetView = JBLogResetView.init(frame: CGRect.init(x: (self.view.bounds.width-600)/2, y: (self.view.bounds.size.height-500)/2, width: 600, height: 500))
        resetView.getModifyCodeHandler = { [weak self] in
            print(" >>>>>>> 获取验证码")
        }
        resetView.isHidden = true
        self.view.addSubview(resetView)
        
        backBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backBtn.isHidden = true
        backBtn.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        self.view.addSubview(backBtn)
    }
    
    //@ back
    func backToMain() -> () {
        logView.isHidden = false
        logView.leftEmmiterNode.particleBirthRate = 1
        logView.rightEmmiterNode.particleBirthRate = 1
        resetView.isHidden = true
        backBtn.isHidden = true
    }
    
    //MARK: - Add Observer
    func addObserverForKeyBoard() -> () {
        NotificationCenter.default.addObserver(self, selector: #selector(changeCenterPartFrame(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(recoverCenterpartFrame(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willChangeF(noti:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    //MARK: - 键盘Frame即将改变
    func willChangeF(noti:Notification) -> () {
        ifRealNeedSet(noti: noti)
    }
    
    //MARK: - 键盘出现
    func changeCenterPartFrame(noti:Notification) -> () {
        ifRealNeedSet(noti: noti)
    }
    
    //@ set真正的位置
    func ifRealNeedSet(noti:Notification) -> () {
        let userInfo = noti.userInfo
        let value = userInfo?[UIKeyboardFrameEndUserInfoKey]
        let boardRect = value as! CGRect
        
        if boardRect.height<=55 {
            
        }else {
            if kIfKeyboardShowed {
                
            }else{
                keyBoardHeight = boardRect.height
                centerSetShowed()
                kIfKeyboardShowed = true
            }
        }
    }
    
    //@ set
    func centerSetShowed() -> () {
        UIView.animate(withDuration: 0.3) {
            self.logView.frame = CGRect.init(x: self.logView.frame.origin.x, y: -100, width: self.logView.frame.size.width, height: self.logView.frame.size.height)
            self.resetView.frame = CGRect.init(x: self.resetView.frame.origin.x, y: -100, width: self.resetView.frame.size.width, height: self.resetView.frame.size.height)
        }
    }
    
    //MARK: - 键盘隐藏
    func recoverCenterpartFrame(noti:Notification) -> () {
        centerSetHide()
        kIfKeyboardShowed = false
    }
    
    //@ set
    func centerSetHide() -> () {

        UIView.animate(withDuration: 0.3) {
            self.logView.frame = CGRect.init(x: self.logView.frame.origin.x, y: (self.view.bounds.size.height-500)/2, width: self.logView.frame.size.width, height: self.logView.frame.size.height)
            self.resetView.frame = CGRect.init(x: self.resetView.frame.origin.x, y: (self.view.bounds.size.height-500)/2, width: self.resetView.frame.size.width, height: self.resetView.frame.size.height)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
