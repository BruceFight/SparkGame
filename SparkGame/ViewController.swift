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

        
        leftEmmiterNode.particleTexture = SKTexture.init(imageNamed: "tree_sel")
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
        
        rightEmmiterNode.particleTexture = SKTexture.init(imageNamed: "tree_sel")
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
        setHuoChaiRen()
        self.view.addSubview(mainSKView)
    }
    
    func setHuoChaiRen() -> () {
        /*
         SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@“monster.atlas”];
         SKTexture *f1 = [atlas textureNamed:@”master-walk1.png”];
         SKTexture *f2 = [atlas textureNamed:@”master-walk2.png”];
         SKTexture *f3 = [atlas textureNamed:@”master-walk3.png”];
         SKTexture *f4 = [atlas textureNamed:@”master-walk4.png”];
         NSArray *monsterWalkTextures = @[f1,f2,f3,f4];
         */
        
        
         let atlas = SKTextureAtlas(named: "go") // atlas name
         var goArray = [SKTexture]()
         
         let imageCount = atlas.textureNames.count
         for index in 0..<imageCount {
            let textureName = "go\(index+1)"
            goArray.append(atlas.textureNamed(textureName))
         }
 
//        let atlas = SKTextureAtlas.init(named: "go")
//        let go1 = atlas.textureNamed("go1")
//        let go2 = atlas.textureNamed("go2")
//        let go3 = atlas.textureNamed("go3")
//        let go4 = atlas.textureNamed("go4")
//        let go5 = atlas.textureNamed("go5")
//        let goArray = [go1,go2,go3,go4,go5]
//        
        /*
         SKAction *walkAnimation = [SKAction animateWithTextures:monsterWalkTextures timePerFrame:0.1]
         [monster runAction:walkAnimation];
         */
        
        let huochaiNode = SKSpriteNode.init()
        huochaiNode.size = CGSize.init(width: 40, height: 80)
        huochaiNode.run(SKAction.animate(with: goArray, timePerFrame: 0.3))
        huochaiNode.position = CGPoint.init(x: 64, y: 100)
        gameScene.addChild(huochaiNode)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

