//
//  ViewController.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/17.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    var mainSKView = SKView()
    var gameScene = SKScene()
    var slightBackNode = SKSpriteNode()
    var nameLabelNode = SKLabelNode()
    var leftEmmiterNode = SKEmitterNode()
    var rightEmmiterNode = SKEmitterNode()
    var logNode = SKSpriteNode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigureGround()
    }
    
    func setConfigureGround() -> () {
        mainSKView = SKView.init(frame: self.view.bounds)
        mainSKView.ignoresSiblingOrder = false
        mainSKView.showsNodeCount = true
        mainSKView.showsFPS = true
        gameScene = SKScene.init(size: mainSKView.bounds.size)
        gameScene.scaleMode = .fill
        
        slightBackNode = SKSpriteNode.init(imageNamed: "image 6")
        slightBackNode.size = gameScene.size
        slightBackNode.position = CGPoint.init(x: gameScene.size.width/2, y: gameScene.size.height/2)
        gameScene.addChild(slightBackNode)
        
        logNode = SKSpriteNode.init(imageNamed: "image 9")
        logNode.size = CGSize.init(width: 400, height: 350)
        logNode.position = CGPoint.init(x: gameScene.size.width/2, y: gameScene.size.height/2)
        
        nameLabelNode = SKLabelNode.init(text: "晓培优")
        nameLabelNode.fontName = "IowanOldStyle-Bold"
        nameLabelNode.fontColor = UIColor.red
        nameLabelNode.position = CGPoint.init(x: 0, y: logNode.size.height/2)

        
        leftEmmiterNode.particleTexture = SKTexture.init(imageNamed: "redstar")
        leftEmmiterNode.position = CGPoint.init(x:-logNode.size.width/2, y: logNode.size.height/2)
        leftEmmiterNode.particlePosition = CGPoint.init(x: 0, y: 0)
        leftEmmiterNode.particleBirthRate = 1
        leftEmmiterNode.particleLifetime = 2
        leftEmmiterNode.particleSize = CGSize.init(width: 10, height: 10)
        leftEmmiterNode.particleAlphaRange = 0.6
        leftEmmiterNode.particleSpeedRange = 80
        leftEmmiterNode.emissionAngleRange = 360
        leftEmmiterNode.targetNode = logNode
        logNode.addChild(leftEmmiterNode)
        
        rightEmmiterNode.particleTexture = SKTexture.init(imageNamed: "redstar")
        rightEmmiterNode.position = CGPoint.init(x:logNode.size.width/2, y: logNode.size.height/2)
        rightEmmiterNode.particlePosition = CGPoint.init(x: 0, y: 0)
        rightEmmiterNode.particleBirthRate = 1
        rightEmmiterNode.particleLifetime = 2
        rightEmmiterNode.particleSize = CGSize.init(width: 10, height: 10)
        rightEmmiterNode.particleAlphaRange = 0.6
        rightEmmiterNode.particleSpeedRange = 80
        rightEmmiterNode.emissionAngleRange = 360
        rightEmmiterNode.targetNode = logNode
        logNode.addChild(rightEmmiterNode)

        /*
        leftEmmiterNode.particlePositionRange = CGVector.init(dx:CGFloat(arc4random_uniform(500)), dy: CGFloat(arc4random_uniform(500)))
        
        var transform = CGAffineTransform.init(translationX: CGFloat(arc4random_uniform(500)), y: CGFloat(arc4random_uniform(500)))
        let path = CGPath.init(ellipseIn: CGRect.init(x: 100, y: 100, width: CGFloat(arc4random_uniform(100)), height: CGFloat(arc4random_uniform(100))), transform: &transform)
        leftEmmiterNode.run(SKAction.follow(path, speed: 40))
        */
        
        logNode.addChild(nameLabelNode)
        gameScene.addChild(logNode)
        mainSKView.presentScene(gameScene)
        self.view.addSubview(mainSKView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        leftEmmiterNode.particleAction = SKAction.moveBy(x: 3, y: 3, duration: 3)
    }
}

