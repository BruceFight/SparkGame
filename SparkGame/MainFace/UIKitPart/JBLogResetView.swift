//
//  JBLogResetView.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/19.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit

class JBLogResetView: JBLogView,UITextFieldDelegate {
    
    //MARK: - parameters
    var titleLabel     = UILabel()
    var phoneFeild     = UITextField()
    var implementLabel = UILabel()
    var getModiCodeBtn = UIButton()
    
    //MARK: - callback
    var getModifyCodeHandler : (() -> ())?
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSuperNode()
        setResetNode(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSuperNode() -> () {
        titleNode.text = "重置密码"
        leftEmmiterNode.particleBirthRate = 0
        rightEmmiterNode.particleBirthRate = 0
    }
    
    func setResetNode(frame: CGRect) -> () {
        titleLabel.text = "使用注册/绑定的手机号重置密码"
        titleLabel.textColor = UIColor.brown
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 12))
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect.init(x: (frame.size.width-titleLabel.bounds.size.width)/2, y: JBLogView.realOriginY + 40, width: titleLabel.bounds.size.width, height: titleLabel.bounds.size.height)
        
        phoneFeild = UITextField.init(frame: CGRect.init(x: JBLogView.realOriginX+40, y: frame.size.height/2-25 , width: frame.size.width-(2*(JBLogView.realOriginX+40)), height: 50))
        phoneFeild.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号", attributes: [NSAttributedString.Key.foregroundColor:UIColor.brown,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        phoneFeild.tintColor = UIColor.white
        phoneFeild.delegate = self
        phoneFeild.backgroundColor = UIColor.yellow
        
        implementLabel.text = "忘记或无绑定手机号,请拨打10108899重置密码"
        implementLabel.textColor = UIColor.brown
        implementLabel.textAlignment = .center
        implementLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 12))
        implementLabel.sizeToFit()
        implementLabel.frame = CGRect.init(x: (frame.size.width-implementLabel.bounds.size.width)/2, y: phoneFeild.frame.maxY+15, width: implementLabel.bounds.size.width, height: implementLabel.bounds.size.height)
        
        getModiCodeBtn = UIButton.init(frame: CGRect.init(x: (frame.size.width-150)/2, y: frame.size.height-190, width: 150, height: 50))
        getModiCodeBtn.backgroundColor = UIColor.lightGray
        getModiCodeBtn.setTitle("获取验证码", for: .normal)
        getModiCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 15))
        getModiCodeBtn.layer.cornerRadius = 25
        getModiCodeBtn.tag = self.hash >> 1
        getModiCodeBtn.addTarget(self, action: #selector(getModiCode(btn:)), for: .touchUpInside)
        
        self.addSubview(titleLabel)
        self.addSubview(phoneFeild)
        self.addSubview(implementLabel)
        self.addSubview(getModiCodeBtn)
    }
   
    //@ btn clicked
    @objc func getModiCode(btn:UIButton) -> () {
        getModifyCodeHandler?()
    }
}
