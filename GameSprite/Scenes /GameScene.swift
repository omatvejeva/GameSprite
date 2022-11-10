//
//  GameScene.swift
//  GameSprite
//
//  Created by Matvejeva, Olivia on 11/10/22.
//

import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate
{
    private var colorMask : Int = 0b0000
    
    
    override func didMove(to view: SKView) -> Void
    {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event : UIEvent?) -> Void
    {
        guard let touch = touches.first
        else {return}
        
        let currentColor = assignColorAndBitmask()
        let width = Int (arc4random() & 50)
        let height = Int (arc4random() % 50)
        let location = touch.location(in: self)
        
        let node : SKSpriteNode
        node = SKSpriteNode(color: currentColor, size: CGSize(width: width, height: height))
        node.position = location
        
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        node.physicsBody?.contactTestBitMask = UInt32(colorMask)
        
        addChild(node)
        
    }
    
    
    private func assignColorAndBitmask() -> UIColor
    {
        let colors : [UIColor] = [.black, .magenta, .systemPink, .blue, .cyan, .green]
        let randomIndex = Int(arc4random()) % colors.count
        colorMask = randomIndex + 1
        
        
        return colors[randomIndex]
        
    }
    
    //MARK: - Collision Methods
    
    private func annihilate(deadNode: SKNode) -> Void
    {
        deadNode.removeFromParent()
    }
    
    private func collisionBetween(_ nodeOne : SKNode, and nodeTwo : SKNode) -> Void
    {
        if (nodeOne.physicsBody?.contactTestBitMask == nodeTwo.physicsBody?.contactTestBitMask)
        {
            annihilate(deadNode: nodeOne)
            annihilate(deadNode: nodeTwo)
        }
    }
    
    func didBegin(_ contact : SKPhysicsContact) -> Void
    {
        guard let first = contact.bodyA.node else {return}
        guard let second = contact.bodyB.node else {return}
        
        collisionBetween(first, and: second)
    }
    
    
    
}
