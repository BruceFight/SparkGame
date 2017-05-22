//
//  JBMainSKView.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/19.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit
import SpriteKit

class JBMainSKView: SKView {

    //MARK: - parameters
    var webView        = UIWebView()
    var mainScene      = SKScene()
    var backgroundNode = SKSpriteNode()
    var huochaiNode    = SKSpriteNode()
    //@ touch callback
    var touchBegan : ((_ touches: Set<UITouch>,_  event: UIEvent?) -> ())?
    var toucheMoved : ((_ touches: Set<UITouch>,_ event: UIEvent?) -> ())?
    var toucheEnded : ((_ touches: Set<UITouch>,_ event: UIEvent?) -> ())?
    //@ touch on 'Node' callback
    var subNodeCallBack : ((_ hash:Int) -> ())?
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsFPS = true
        self.showsNodeCount = true
        self.ignoresSiblingOrder = false
        self.isUserInteractionEnabled = true
        
        mainScene.size = frame.size
        mainScene.scaleMode = .fill
        
        //@ backgroundNode
        backgroundNode = SKSpriteNode.init(imageNamed: "image 4")
        backgroundNode.size = mainScene.size
        backgroundNode.position = CGPoint.init(x: mainScene.size.width/2, y: mainScene.size.height/2)
        mainScene.addChild(backgroundNode)
        
        //@ 设置火柴人
        let goArray = JBControl.instance.textures(name: "run")
        let huochaiNode = JBControl.instance.animationNode(size:CGSize.init(width: 60, height: 80),textureArr:goArray,position:CGPoint.init(x: 64, y: 100))
        self.huochaiNode = huochaiNode
        JBControl.instance.setScale(from: 0.75, to: 1, with: huochaiNode) {
            // 动画完后
        }
        mainScene.addChild(huochaiNode)
        self.presentScene(mainScene)
    }
    
    //MARK: - set webview
    func setWebView(to:CGRect) -> () {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
            self.webView = UIWebView.init(frame: (to==CGRect.zero) ? CGRect.init(x: 30, y: 30, width: self.bounds.size.width-60, height: self.bounds.size.height-100) : to)
            self.webView.loadRequest(URLRequest.init(url: URL.init(string: "http://www.baidu.com")!))
            
            JBControl.instance.setScale(from: 0.75, to: 1, with: self.webView, finished: {
                //完成缩放
            })
            self.addSubview(self.webView)
        })
    }

    //MARK: - reset scene
    func resetScene(bgImage:String) -> () {
        
//        let transition = SKTransition.fade(withDuration: 2.0)// 1 全黑->变换
//        let transition = SKTransition.crossFade(withDuration: 2.0)// 2 直接变换
//        let transition = SKTransition.fade(with: UIColor.red, duration: 2.0)// 3 全黑底色变为红色->变换
//        let transition = SKTransition.flipHorizontal(withDuration: 2.0)// 4 Y轴旋转
//        let transition = SKTransition.flipVertical(withDuration: 2.0)// 5 X轴旋转
//        let transition = SKTransition.reveal(with: .left, duration: 2.0)// 6 移除侧滑(双层)
//        let transition = SKTransition.moveIn(with: .left, duration: 2.0)// 7 移入侧滑(双层)
//        let transition = SKTransition.push(with: .left, duration: 2.0)// 8 平层侧滑(单层)
//        let transition = SKTransition.doorsOpenHorizontal(withDuration: 2.0)// 9 水平开门式
//        let transition = SKTransition.doorsOpenVertical(withDuration: 2.0)// 10 垂直开门式
//        let transition = SKTransition.doorsCloseHorizontal(withDuration: 2.0)// 11 水平关门式
//        let transition = SKTransition.doorsCloseVertical(withDuration: 2.0)// 12 垂直关门式
        let transition = SKTransition.doorway(withDuration: 2.0)// 13 3D开门式
        let newScene = SKScene.init(size: self.bounds.size)
        newScene.scaleMode = .fill
        newScene.backgroundColor = UIColor.clear
        newScene.position = CGPoint.init(x: (self.bounds.size.width)/2, y: (self.bounds.size.height)/2)
        let newBackNode = SKSpriteNode.init(imageNamed: bgImage)
        newBackNode.size = mainScene.size
        newBackNode.position = CGPoint.init(x: mainScene.size.width/2, y: mainScene.size.height/2)
        newScene.addChild(newBackNode)
        self.presentScene(newScene, transition: transition)//executed in main thread !
        backgroundNode = newBackNode
        mainScene = newScene
    }
    
    func addSubNode(node:SKNode) -> () {
        
        self.mainScene.addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JBMainSKView {
    
    //MARK: - touch delegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // current touch-point
        let touchPoint = touches.first?.location(in: self.mainScene)
        // Toggle pause when touching in the pause node.
        if self.huochaiNode === self.mainScene.atPoint(touchPoint!) {
            subNodeCallBack?(self.huochaiNode.hash)
        }
        touchBegan?(touches,event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        toucheMoved?(touches,event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        toucheEnded?(touches,event)
    }
    
}
