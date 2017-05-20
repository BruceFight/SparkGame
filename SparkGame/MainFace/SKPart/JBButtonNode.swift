//
//  JBButtonNode.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/19.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

/**
 *  even though 'SKNode' class ,also can be interacted with user. before that ,💕 set 'isUserInteractionEnabled' for true
 *  then override 'touchesBegan' , 'touchesEnded'... ,you can write the event inside . due to 'SKNode' is subclass of 'UIResponder', so it also can be responde to the touch of user
 */
import UIKit
import SpriteKit

/// Test Part ,Can be igmnored !!!💕
class JBButtonNode: SKNode {
    
    var imageNode = SKSpriteNode()
    var labelNode = SKLabelNode()
    var clickedHandler : (() -> ())?
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        
        imageNode = SKSpriteNode.init(imageNamed: "redstar")
        imageNode.position = self.position

        labelNode = SKLabelNode.init(text: "Hello!")
        labelNode.position = imageNode.position
        imageNode.addChild(labelNode)
        self.addChild(imageNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func copy(with zone: NSZone? = nil) -> Any {
        let newButton = super.copy(with: zone) as! JBButtonNode
        return newButton
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("点击了按钮 >>> ")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        clickedHandler?()
        print(" >>>>>>>>>>>>>>>> ")
    }
}
