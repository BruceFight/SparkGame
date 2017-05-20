//
//  JBControl.swift
//  SparkGame
//
//  Created by Bruce Jiang on 2017/5/19.
//  Copyright © 2017年 Bruce Jiang. All rights reserved.
//

/**
 *  the manager that control some view show type or SKNode-relatived setting !
 *  you can choose the right one according to 'MARK' before the 'func' name.
 */

import UIKit
import SpriteKit

class JBControl: NSObject {
    
    //MARK: - Single
    public static let instance = JBControl()

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
    
    //MARK: - set scale animation for 'with' which's unsured, maybe 'UIView' or 'SKNode' type !
    func setScale<T>(from:CGFloat,to:CGFloat,with:T,finished:(() -> ())?) -> () {
        let withObject = with as AnyObject
        if withObject.isKind(of:UIView.self) {
            let withView = with as! UIView
            
            UIView.animate(withDuration: 0.1, animations: {
                withView.transform = CGAffineTransform.init(scaleX: from, y: from)
            }) { (true) in
                UIView.animate(withDuration: 0.1, animations: {
                    withView.transform = CGAffineTransform.init(scaleX: to, y: to)
                })
            }
        }else if withObject.isKind(of: SKNode.self) {
            let withNode = with as! SKNode
            let scaleIn = SKAction.scale(to: from, duration: 0.2)
            let scaleOut = SKAction.scale(to: to, duration: 0.2)
            withNode.run(SKAction.sequence([scaleIn,scaleOut]))
        }
    }

}
