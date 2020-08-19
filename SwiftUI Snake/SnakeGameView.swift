//
//  SnakeGameView.swift
//  SwiftUI Snake
//
//  Created by Antoine on 19/08/2020.
//

import SwiftUI

struct SnakeGameView: View {
    
    @ObservedObject var game: SnakeGame
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                Color.red.opacity(0.3)
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: game.bodyWidth, height: game.bodyWidth)
                    .offset(x: game.bodyPosition[0].x * game.bodyWidth,
                            y: game.bodyPosition[0].y * game.bodyWidth)
                    .onTapGesture {
                        print(game.bodyPosition[0])
                        withAnimation() {
                            game.addX()
                        }
                        
                    }
                
                    
            }
        }
    }
}

