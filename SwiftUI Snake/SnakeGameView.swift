//
//  SnakeGameView.swift
//  SwiftUI Snake
//
//  Created by Antoine on 19/08/2020.
//

import SwiftUI
import AVFoundation

struct SnakeGameView: View {
    
    @ObservedObject var game: SnakeGame
    
    var body: some View {
        let dragGesture = DragGesture().onEnded { value in
            game.changeDirectionWithTranslation(value.translation)
        }
        
        return GeometryReader { geo in
            VStack {
                Text("SCORE: \(game.bodyPosition.count - 1)")
                ZStack(alignment: .topLeading) {
                    Color.red.opacity(0.3)
                    ZStack {
                        Rectangle().fill(Color.clear)
                        Text("🍎")
                    }   .font(.system(size: game.bodyWidth * 0.7))
                    .frame(width: game.bodyWidth, height: game.bodyWidth)
                    .offset(x: game.foodPosition.x * game.bodyWidth,
                                y: game.foodPosition.y * game.bodyWidth)
                    
                    ForEach(0..<game.bodyPosition.count, id: \.self) { i in
                        if i == -1 {
                            SnakeHead()
                                .fill(game.isGameOver ? Color.red : Color.blue)
                                .frame(width: game.bodyWidth, height: game.bodyWidth)
                                .rotationEffect(rotationForSnakeHead())
                                .offset(x: game.bodyPosition[i].x * game.bodyWidth,
                                        y: game.bodyPosition[i].y * game.bodyWidth)
                                
                        } else {
                            Circle()
                                .fill(game.isGameOver ? Color.red : Color.blue)
                                .frame(width: game.bodyWidth, height: game.bodyWidth)
                                .offset(x: game.bodyPosition[i].x * game.bodyWidth,
                                        y: game.bodyPosition[i].y * game.bodyWidth)
                        }
                        
                    }
                    
                    if game.isGameOver {
                        Text("GAME OVER: 3 TAPS TO RESTART")
                    }
                }
                .frame(width: game.gameBoard.width * game.bodyWidth, height: game.gameBoard.height * game.bodyWidth)
                .gesture(dragGesture)
                .onTapGesture(count: 3, perform: {
                    game.reset()
                })
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
    
    func rotationForSnakeHead() -> Angle {
        switch game.direction {
        case .up:
            return Angle(degrees: 0)
        case .down:
            return Angle(degrees: 180)
        case .right:
            return Angle(degrees: 90)
        case .left:
            return Angle(degrees: 270)
        }
    }
}

