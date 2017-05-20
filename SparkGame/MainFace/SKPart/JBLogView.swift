//
//  JBLogView.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/19.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit
import SpriteKit

class JBLogView: SKView {

    //MARK: - parameters
    var mainScene        = SKScene()
    var titleNode        = SKLabelNode()
    var centerNode       = SKSpriteNode()
    var leftEmmiterNode  = SKEmitterNode()
    var rightEmmiterNode = SKEmitterNode()
    
    public static let realOriginX : CGFloat = 100
    public static let realOriginY : CGFloat = 100
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.ignoresSiblingOrder = false
        self.backgroundColor = UIColor.clear
        //@ mainScene
        mainScene = SKScene.init(size: frame.size)
        mainScene.scaleMode = .fill
        mainScene.backgroundColor = UIColor.clear
        mainScene.position = CGPoint.init(x: frame.width/2, y: frame.height/2)
        
        //@ titleNode
        titleNode = SKLabelNode.init(text: "晓培优")
        titleNode.fontName = "MarkerFelt-Thin"
        titleNode.fontColor = UIColor.red
        titleNode.position = CGPoint.init(x: mainScene.size.width/2, y: mainScene.size.height-100)//?
        mainScene.addChild(titleNode)
        
        //@ centerNode
        centerNode = SKSpriteNode.init(imageNamed: "image 9")
        centerNode.size = CGSize.init(width:frame.size.width-200, height: frame.size.height-200)
        centerNode.position = CGPoint.init(x: mainScene.size.width/2, y: mainScene.size.height/2)
        setEmitterNode(node: leftEmmiterNode, position: CGPoint.init(x:-centerNode.size.width/2, y: centerNode.size.height/2))
        setEmitterNode(node: rightEmmiterNode, position: CGPoint.init(x:centerNode.size.width/2, y: centerNode.size.height/2))
        mainScene.addChild(centerNode)
        self.presentScene(mainScene)
    }

    //@ 设置左右粒子
    func setEmitterNode(node:SKEmitterNode,position:CGPoint) -> () {
        node.particleTexture = SKTexture.init(imageNamed: "tree_sel")
        node.position = CGPoint.init(x:centerNode.size.width/2, y: centerNode.size.height/2)
        node.position = position
        node.particlePosition = CGPoint.init(x: 0, y: 0)
        node.particleBirthRate = 1
        node.particleLifetime = 2
        node.particleSize = CGSize.init(width: 10, height: 10)
        node.particleAlphaRange = 0.6
        node.particleSpeedRange = 80
        node.emissionAngleRange = 360
        node.targetNode = centerNode
        centerNode.addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
