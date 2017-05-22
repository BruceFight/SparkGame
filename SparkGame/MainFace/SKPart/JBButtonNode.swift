//
//  JBButtonNode.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/19.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit
import SpriteKit

/// Test Part ,Can be igmnored !!!💕
class JBButtonNode: SKSpriteNode {//SKNode
    
    var imageNode = SKSpriteNode()
    var labelNode = SKLabelNode()
    
    init(texture: SKTexture?, color: UIColor, size: CGSize,title:String) {
        super.init(texture: texture, color: color, size: size)
        self.texture = nil
        self.size = size

        imageNode = SKSpriteNode.init(texture: texture)
        imageNode.size = CGSize.init(width:size.height, height: size.height)
        imageNode.position = CGPoint.init(x: -(size.height)/2, y: 0)
        labelNode = SKLabelNode.init(text: title)
        labelNode.position = CGPoint.init(x: size.height/2, y: -(size.height)/4)
        
        self.addChild(imageNode)
        self.addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Button clicked !")
    }
    
}
