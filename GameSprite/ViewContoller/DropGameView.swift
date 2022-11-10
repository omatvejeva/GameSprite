//
//  DropGameView.swift
//  GameSprite
//
//  Created by Matvejeva, Olivia on 11/10/22.
//

import SwiftUI
import SpriteKit

struct DropGameView: View
{
    let width : CGFloat = 300
    let height : CGFloat = 500
    
    private var simpleScene : GameScene
    {
        let scene = GameScene()
        scene.size = CGSize(width: width, height: height)
        scene.scaleMode = .fill
        
        return scene 
    }
    
    
    var body: some View
    {
        VStack
        {
           
            Text("Game? ")
            SpriteView(scene: simpleScene)
                .frame(width: width, height: height)
        }
        .padding()
    }
}

struct DropGameView_Previews: PreviewProvider
{
    static var previews: some View
    {
        DropGameView()
    }
}
