//
//  JBLogMainView.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/19.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit

class JBLogMainView: JBLogView ,UITextFieldDelegate{
    
    //@ UIKit parameters are relative to 'SKView' clzass !!!
    var iconImageNode     = UIButton()
    var secretImageNode   = UIButton()
    var nameTextField     = UITextField()
    var secretTextField   = UITextField()
    var rememberSecretBtn = UIButton()
    var forgetSecretbtn   = UIButton()
    var logBtn            = UIButton()
    
    //@ 界面按钮触发回调
    var centerBtnTouchHandler : ((_ btn:UIButton,_ hash:Int) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLogNode(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLogNode(frame: CGRect) -> () {
        
        
        iconImageNode = UIButton.init(frame: CGRect.init(x: JBLogView.realOriginX+40, y: JBLogView.realOriginY+40, width: 40, height: 40))
        iconImageNode.setImage(#imageLiteral(resourceName: "me_sel.png"), for: .normal)
        nameTextField = UITextField.init(frame: CGRect.init(x: iconImageNode.frame.maxX+20, y: iconImageNode.frame.minY, width: frame.size.width-iconImageNode.frame.maxX-160, height: 40))
        nameTextField.tag = nameTextField.hash
        nameTextField.delegate = self
        nameTextField.backgroundColor = UIColor.yellow
//        nameTextField.background = #imageLiteral(resourceName: "prompt_2")

        secretImageNode = UIButton.init(frame: CGRect.init(x: iconImageNode.frame.origin.x, y: iconImageNode.frame.maxY+20, width: 40, height: 40))
        secretImageNode.setImage(#imageLiteral(resourceName: "secret.png"), for: .normal)
        secretTextField = UITextField.init(frame: CGRect.init(x: nameTextField.frame.minX, y: secretImageNode.frame.minY, width: nameTextField.frame.size.width, height: 40))
        secretTextField.tag = secretTextField.hash
        secretTextField.delegate = self
        secretTextField.backgroundColor = UIColor.yellow
//        secretTextField.background = #imageLiteral(resourceName: "prompt_2")

        logBtn = UIButton.init(frame: CGRect.init(x: (frame.size.width-150)/2, y: frame.size.height-190, width: 150, height: 50))
        logBtn.backgroundColor = UIColor.lightGray
        logBtn.setTitle("登录", for: .normal)
        logBtn.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: 15)
        logBtn.layer.cornerRadius = 25
        logBtn.tag = self.hash >> 1
        logBtn.addTarget(self, action: #selector(centerBtnTouch(btn:)), for: .touchUpInside)
        
        rememberSecretBtn.setTitle("记住密码", for: .normal)
        rememberSecretBtn.setTitleColor(UIColor.brown, for: .normal)
        rememberSecretBtn.setImage(#imageLiteral(resourceName: "tree_sel.png"), for: .normal)
        rememberSecretBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: 12)
        rememberSecretBtn.sizeToFit()
        rememberSecretBtn.tag = self.hash >> 2
        rememberSecretBtn.addTarget(self, action: #selector(centerBtnTouch(btn:)), for: .touchUpInside)
        rememberSecretBtn.frame = CGRect.init(x: frame.size.width/2-rememberSecretBtn.bounds.size.width, y: logBtn.frame.minY-45, width: rememberSecretBtn.bounds.size.width, height: 30)
        
        forgetSecretbtn.setTitle("忘记密码", for: .normal)
        forgetSecretbtn.setTitleColor(UIColor.brown, for: .normal)
        forgetSecretbtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: 12)
        forgetSecretbtn.sizeToFit()
        forgetSecretbtn.tag = self.hash >> 3
        forgetSecretbtn.addTarget(self, action: #selector(centerBtnTouch(btn:)), for: .touchUpInside)
        forgetSecretbtn.frame = CGRect.init(x: frame.size.width/2+20, y: rememberSecretBtn.frame.minY, width: forgetSecretbtn.bounds.size.width, height: 30)
      
        
        self.addSubview(iconImageNode)
        self.addSubview(nameTextField)
        self.addSubview(secretImageNode)
        self.addSubview(secretTextField)
        
        self.addSubview(logBtn)
        self.addSubview(rememberSecretBtn)
        self.addSubview(forgetSecretbtn)
    }

}

extension JBLogMainView {
    
    //MARK: - 界面按钮触发
    func centerBtnTouch(btn:UIButton) -> () {
        print("💕 >>>>>>>>>> \(btn.tag)")
        centerBtnTouchHandler?(btn,self.hash)
    }
    
}
