//
//  DropGameView.swift
//  GameSprite
//
//  Created by Matvejeva, Olivia on 11/10/22.
//

import SwiftUI

struct DropGameView: View
{
    let width : CGFloat = 300
    let heigtht : CGFloat = 500
    
    private var simpleScene : GameScene
    {
        let scene = GameScene()
        scene.size = CGSize(width: width, height: heigtht)
        scene.scaleMode = .fill
        
        return scene 
    }
    
    
    var body: some View
    {
        VStack
        {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
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
