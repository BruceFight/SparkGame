//
//  JBAnimationView.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/19.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

import UIKit
import SpriteKit

class JBAnimationView: NSObject {
    
    //MARK: - Single
    public static let instance = JBAnimationView()

    //MARK: - return 'SKSpriteNode' animated
    func animationNode(size:CGSize,textureArr:[SKTexture],position:CGPoint) -> SKSpriteNode{
        let animNode = SKSpriteNode.init()
        animNode.isUserInteractionEnabled = true
        animNode.size = size
        animNode.run(SKAction.repeatForever(SKAction.animate(with: textureArr, timePerFrame: 0.08)))
        animNode.position = position
        return animNode
    }
    
    //MARK: - return array of type 'SKTexture'
    /**
        - the images-file must be named with 'name%d', %d start with 1 ... n
     */
    func textures(name:String) -> [SKTexture] {
        let atlas = SKTextureAtlas(named: name) // atlas name
        var textureArray = [SKTexture]()
        
        let imageCount = atlas.textureNames.count
        for index in 0..<imageCount {
            let textureName = "\(name)\(index+1)"
            textureArray.append(atlas.textureNamed(textureName))
        }
        return textureArray
    }

}
