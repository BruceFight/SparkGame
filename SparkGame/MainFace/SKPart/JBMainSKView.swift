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
    //@ touch callback
    var touchBegan : ((_ touches: Set<UITouch>,_  event: UIEvent?) -> ())?
    var toucheMoved : ((_ touches: Set<UITouch>,_ event: UIEvent?) -> ())?
    var toucheEnded : ((_ touches: Set<UITouch>,_ event: UIEvent?) -> ())?
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsFPS = true
        self.showsNodeCount = true
        self.isAsynchronous = true
        self.ignoresSiblingOrder = false
        self.isUserInteractionEnabled = true
        
        mainScene.size = frame.size
        mainScene.scaleMode = .fill
        
        //@ backgroundNode
        backgroundNode = SKSpriteNode.init(imageNamed: "image 6")
        backgroundNode.size = mainScene.size
        backgroundNode.position = CGPoint.init(x: mainScene.size.width/2, y: mainScene.size.height/2)
        mainScene.addChild(backgroundNode)
        
        //@ 设置火柴人
        let goArray = JBControl.instance.textures(name: "run")
        let huochaiNode = JBControl.instance.animationNode(size:CGSize.init(width: 60, height: 80),textureArr:goArray,position:CGPoint.init(x: 64, y: 100))
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
            
            JBControl.instance.setScale(from: 0.95, to: 1, with: self.webView, finished: {
                //完成缩放
            })
            self.addSubview(self.webView)
        })
    }
    
    //MARK: - reset scene
    func resetScene(bgImage:String) -> () {
        let transition = SKTransition.fade(withDuration: 2.0)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JBMainSKView {
    
    //MARK: - touch delegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchBegan?(touches,event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        toucheMoved?(touches,event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        toucheEnded?(touches,event)
    }
}
