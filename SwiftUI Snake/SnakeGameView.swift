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
        let dragGesture = DragGesture().onEnded { value in
            game.changeDirectionWithTranslation(value.translation)
        }
        
        return GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                Color.red.opacity(0.3)
                Rectangle()
                    .fill(Color.green)
                    .frame(width: game.bodyWidth, height: game.bodyWidth)
                    .offset(x: game.foodPosition.x * game.bodyWidth,
                            y: game.foodPosition.y * game.bodyWidth)
                Rectangle()
                    .fill(game.isGameOver ? Color.red : Color.blue)
                    .frame(width: game.bodyWidth, height: game.bodyWidth)
                    .offset(x: game.bodyPosition[0].x * game.bodyWidth,
                            y: game.bodyPosition[0].y * game.bodyWidth)
            }.gesture(dragGesture)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                    game.moveSnake()
                }
            }
        }
    }
}

