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
    
    private let scoreNode : SKLabelNode = SKLabelNode(fontNamed: "Didot")
    
    private var score : Int = -0
    {
        didSet
        {
            scoreNode.text = "Score \(score)"
        }
    }
    private var gameBlocks : [SKSpriteNode] = []
    
    override func didMove(to view: SKView) -> Void
    {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        //score
        scoreNode.zPosition = 2
        scoreNode.position.x = 150
        scoreNode.position.y = 480
        
        addChild(scoreNode)
        score = 0
        
        //adding sound
        let backgroundMusic = SKAudioNode(fileNamed: "Never Gonna Give You Up Original")
        backgroundMusic.name = "music"
        
        addChild(backgroundMusic)
        
        loadBlocks()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event : UIEvent?) -> Void
    {
        guard let touch = touches.first
        else {return}
        

        
        let location = touch.location(in: self)
        
        if (!gameBlocks.isEmpty)
        {
            let node : SKSpriteNode = gameBlocks.removeLast()
            node.position = location
            addChild(node)
            
        }
        else
        {
            endGame()
        }
    }
    
    private func endGame() -> Void
    {
        let transition = SKTransition.fade(with: .green, duration: 5)
        let endingScene = EndGameSceen()
        endingScene.score = score
        endingScene.size = CGSize(width: 300, height: 500)
        endingScene.scaleMode = .fill
        
        self.view?.presentScene(endingScene, transition: transition)
    }
    
    private func loadBlocks() -> Void
    {
        for _ in 0 ..< 50
        {
            let currentColor = assignColorAndBitmask()
            let width = Int (arc4random() & 50)
            let height = Int (arc4random() % 50)
            
            let node : SKSpriteNode
            node = SKSpriteNode(color: currentColor, size: CGSize(width: width, height: height))
            
            node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
            node.physicsBody?.contactTestBitMask = UInt32(colorMask)
            
            gameBlocks.append(node)
        }
    }
    
    private func assignColorAndBitmask() -> UIColor
    {
        let colors : [UIColor] = [.black, .magenta, .systemPink, .blue, .cyan, .green]
        let randomIndex = Int(arc4random()) % colors.count
        colorMask = randomIndex + 1
        
        
        return colors[randomIndex]
        
    }
    
    private func updateSound() -> Void
    {
        if let sound = childNode(withName: "music")
        {
            let speedUp = SKAction.changePlaybackRate(by: 1.5, duration: 10)
            sound.run(speedUp)
        }
    }
    
    //MARK: - Collision Methods
    
    private func explosionEffect(at location : CGPoint) -> Void
    {
        if let explosion = SKEmitterNode(fileNamed: "SparkParticle")
        {
            explosion.position = location
            addChild(explosion)
            
            let waitTime = SKAction.wait(forDuration: 5)
            let removeExplostion = SKAction.removeFromParent()
            let explosiveSequence = SKAction.sequence([waitTime, removeExplostion])
            
            let effectSound = SKAction.playSoundFileNamed("torchwood update", waitForCompletion: false )
            run(effectSound)
            
            explosion.run(explosiveSequence)
        }
    }
    
    private func annihilate(deadNode: SKNode) -> Void
    {
        explosionEffect(at: deadNode.position)
        deadNode.removeFromParent()
        score += 5
        updateSound()
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
