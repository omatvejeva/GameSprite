//
//  EndGameSceen.swift
//  GameSprite
//
//  Created by Matvejeva, Olivia on 11/14/22.
//

import SpriteKit

class EndGameSceen : SKScene
{
    var score : Int = 0
    
    override func didMove(to view: SKView) -> Void
    {
        backgroundColor = .orange
        
        let scoreNode = SKLabelNode(fontNamed: "Copperplate-Bold")
        scoreNode.zPosition = 2
        scoreNode.position.x = frame.midX
        scoreNode.position.y = frame.midY + 30
        scoreNode.fontSize = 20
        scoreNode.fontColor = .black
        scoreNode.text = "Score: \(score)"
        
        let endNode = SKLabelNode(fontNamed: "Copperplate-Bold")
        endNode.zPosition = 2
        endNode.position.x = frame.midX
        endNode.position.y = frame.midY + 10
        endNode.fontSize = 25
        endNode.fontColor = .darkGray
        endNode.text = "Game Over!"
        
        
        let restartNode = SKLabelNode(fontNamed: "Copperplate-Bold")
        restartNode.zPosition = 2
        restartNode.position.x = frame.midX
        restartNode.position.y = frame.midY
        restartNode.fontSize = 20
        restartNode.fontColor = .black
        restartNode.text = "Pinch to restart"
        
        addChild(scoreNode)
        addChild(endNode)
        addChild(restartNode)
        
        let pinchRecognizer  = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        self.view?.addGestureRecognizer(pinchRecognizer)
        
    }
    
    private func restart() -> Void
    {
        let transition = SKTransition.fade(with: .purple, duration: 12)
        let restartScene = GameScene()
        restartScene.size = CGSize(width: 300, height: 500)
        restartScene.scaleMode = .fill
        self.view?.presentScene(restartScene, transition: transition)
    }
    
    @objc
    private func handlePinch(recognizer: UIPinchGestureRecognizer) -> Void
    {
        if recognizer.state == .ended
        {
            restart() 
        }
    }
}
