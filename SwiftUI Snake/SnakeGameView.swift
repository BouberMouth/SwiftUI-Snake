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
                ForEach(0..<game.bodyPosition.count, id: \.self) { i in
                    Rectangle()
                        .fill(game.isGameOver ? Color.red : Color.blue)
                        .frame(width: game.bodyWidth, height: game.bodyWidth)
                        .offset(x: game.bodyPosition[i].x * game.bodyWidth,
                                y: game.bodyPosition[i].y * game.bodyWidth)
                }
            }.frame(width: game.gameBoard.width * game.bodyWidth, height: game.gameBoard.height * game.bodyWidth)
            .gesture(dragGesture)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    withAnimation(.linear(duration: 0.1)) {
                        game.moveSnake()
                    }
                }
            }
        }
    }
}

