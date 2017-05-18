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

    var mainSKView = SKView()
    var gameScene = SKScene()
    var slightBackNode = SKSpriteNode()
    var nameLabelNode = SKLabelNode()
    var leftEmmiterNode = SKEmitterNode()
    var rightEmmiterNode = SKEmitterNode()
    
    //@ forLogNode
    var logNode = SKSpriteNode()
    var nameTextField = UITextField()
    var secretTextField = UITextField()
    
    fileprivate var keyBoardHeight : CGFloat = 0
    fileprivate var kIfKeyboardShowed : Bool = false
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainView()
    }
    
    func setMainView() -> () {
        //@ mainSKView
        mainSKView = SKView.init(frame: self.view.bounds)
        mainSKView.ignoresSiblingOrder = false
        mainSKView.showsNodeCount = true
        mainSKView.showsFPS = true
        gameScene = SKScene.init(size: mainSKView.bounds.size)
        gameScene.scaleMode = .fill
        //@ slightBackNode
        slightBackNode = SKSpriteNode.init(imageNamed: "image 6")
        slightBackNode.size = gameScene.size
        slightBackNode.position = CGPoint.init(x: gameScene.size.width/2, y: gameScene.size.height/2)
        gameScene.addChild(slightBackNode)
        
        mainSKView.presentScene(gameScene)
        setHuoChaiRen()
        setLogView()
        setLogNode()
        self.view.addSubview(mainSKView)
    }
    
    func setLogView() -> () {
        //@ logNode
        logNode = SKSpriteNode.init(imageNamed: "image 9")
        logNode.size = CGSize.init(width: 400, height: 350)
        logNode.position = CGPoint.init(x: gameScene.size.width/2, y: gameScene.size.height/2)
        gameScene.addChild(logNode)
        //@ nameLabelNode
        nameLabelNode = SKLabelNode.init(text: "晓培优")
        nameLabelNode.fontName = "Zapfino"
        nameLabelNode.fontColor = UIColor.red
        nameLabelNode.position = CGPoint.init(x: 0, y: logNode.size.height/2)
        //@ emitterNode
        setEmitterNode(node: leftEmmiterNode, position: CGPoint.init(x:-logNode.size.width/2, y: logNode.size.height/2))
        setEmitterNode(node: rightEmmiterNode, position: CGPoint.init(x:logNode.size.width/2, y: logNode.size.height/2))
        
        logNode.addChild(nameLabelNode)
    }
    
    //@ 设置左右粒子
    func setEmitterNode(node:SKEmitterNode,position:CGPoint) -> () {
        node.particleTexture = SKTexture.init(imageNamed: "tree_sel")
        node.position = CGPoint.init(x:logNode.size.width/2, y: logNode.size.height/2)
        node.position = position
        node.particlePosition = CGPoint.init(x: 0, y: 0)
        node.particleBirthRate = 1
        node.particleLifetime = 2
        node.particleSize = CGSize.init(width: 10, height: 10)
        node.particleAlphaRange = 0.6
        node.particleSpeedRange = 80
        node.emissionAngleRange = 360
        node.targetNode = logNode
        logNode.addChild(node)
    }
    
    func setLogNode() -> () {
        nameTextField = UITextField.init(frame: CGRect.init(x: (slightBackNode.size.width)/2-100, y: (slightBackNode.size.height)/2-30, width: 200, height: 30))
        nameTextField.tag = nameTextField.hash
        nameTextField.delegate = self
        nameTextField.backgroundColor = UIColor.clear
        nameTextField.background = #imageLiteral(resourceName: "tree_sel.png")
        
        secretTextField = UITextField.init(frame: CGRect.init(x: (slightBackNode.size.width)/2-100, y: (slightBackNode.size.height)/2+30, width: 200, height: 30))
        secretTextField.tag = secretTextField.hash
        secretTextField.delegate = self
        secretTextField.backgroundColor = UIColor.clear
        mainSKView.addSubview(nameTextField)
        mainSKView.addSubview(secretTextField)
        addObserverForKeyBoard()
    }
    
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
            return
        }else {
            if kIfKeyboardShowed {
                return
            }else{
                keyBoardHeight = boardRect.height
                centerSetShowed()
                kIfKeyboardShowed = true
            }
        }
    }
    
    //@ set
    func centerSetShowed() -> () {
        logNode.run(SKAction.move(by: CGVector.init(dx: 0, dy: keyBoardHeight-(slightBackNode.size.height-logNode.size.height)/2), duration: 0.3))
        UIView.animate(withDuration: 0.3) {
            self.nameTextField.frame = CGRect.init(x: self.nameTextField.frame.origin.x, y: self.nameTextField.frame.origin.y - (self.keyBoardHeight-(self.slightBackNode.size.height-self.logNode.size.height)/2), width: self.nameTextField.bounds.size.width, height: self.nameTextField.bounds.size.height)
            self.secretTextField.frame = CGRect.init(x: self.secretTextField.frame.origin.x, y: self.secretTextField.frame.origin.y - (self.keyBoardHeight-(self.slightBackNode.size.height-self.logNode.size.height)/2), width: self.secretTextField.bounds.size.width, height: self.secretTextField.bounds.size.height)
        }
    }
    
    //MARK: - 键盘隐藏
    func recoverCenterpartFrame(noti:Notification) -> () {
        centerSetHide()
        kIfKeyboardShowed = false
    }
    
    //@ set
    func centerSetHide() -> () {
        logNode.run(SKAction.move(by: CGVector.init(dx: 0, dy: -(keyBoardHeight-(slightBackNode.size.height-logNode.size.height)/2)), duration: 0.3))
        UIView.animate(withDuration: 0.3) {
            self.nameTextField.frame = CGRect.init(x: self.nameTextField.frame.origin.x, y: self.nameTextField.frame.origin.y + (self.keyBoardHeight-(self.slightBackNode.size.height-self.logNode.size.height)/2), width: self.nameTextField.bounds.size.width, height: self.nameTextField.bounds.size.height)
            self.secretTextField.frame = CGRect.init(x: self.secretTextField.frame.origin.x, y: self.secretTextField.frame.origin.y + (self.keyBoardHeight-(self.slightBackNode.size.height-self.logNode.size.height)/2), width: self.secretTextField.bounds.size.width, height: self.secretTextField.bounds.size.height)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //@ 设置火柴人
    func setHuoChaiRen() -> () {
        
         let atlas = SKTextureAtlas(named: "run") // atlas name
         var goArray = [SKTexture]()
         
         let imageCount = atlas.textureNames.count
         for index in 0..<imageCount {
            let textureName = "run\(index+1)"
            goArray.append(atlas.textureNamed(textureName))
         }

        let huochaiNode = SKSpriteNode.init()
        huochaiNode.size = CGSize.init(width: 60, height: 80)
        huochaiNode.run(SKAction.repeatForever(SKAction.animate(with: goArray, timePerFrame: 0.08)))
        huochaiNode.position = CGPoint.init(x: 64, y: 100)
        gameScene.addChild(huochaiNode)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}

extension ViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !kIfKeyboardShowed {
            self.nameTextField.resignFirstResponder()
            self.secretTextField.resignFirstResponder()
        }
    }
}
