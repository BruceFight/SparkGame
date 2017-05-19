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

    var mainScene = SKScene()
    var backgroundNode = SKSpriteNode()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.ignoresSiblingOrder = false
        self.showsNodeCount = true
        self.showsFPS = true
        
        mainScene = SKScene.init(size: frame.size)
        mainScene.scaleMode = .fill
        
        //@ backgroundNode
        backgroundNode = SKSpriteNode.init(imageNamed: "image 6")
        backgroundNode.size = mainScene.size
        backgroundNode.position = CGPoint.init(x: mainScene.size.width/2, y: mainScene.size.height/2)
        mainScene.addChild(backgroundNode)
        
        //@ 设置火柴人
        let goArray = JBAnimationView.instance.textures(name: "run")
        mainScene.addChild(JBAnimationView.instance.animationNode(size:CGSize.init(width: 60, height: 80),textureArr:goArray,position:CGPoint.init(x: 64, y: 100)))
        
        self.presentScene(mainScene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
