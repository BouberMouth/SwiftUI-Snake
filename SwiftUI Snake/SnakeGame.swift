//
//  SnakeGame.swift
//  SwiftUI Snake
//
//  Created by Antoine on 19/08/2020.
//

import SwiftUI

class SnakeGame: ObservableObject {
    
    let bodyWidth: CGFloat
    @Published var bodyPosition: [CGPoint]
    @Published var foodPosition: CGPoint
    let maxX: CGFloat
    let maxY: CGFloat
    var direction: Direction = .down
    var isGameOver: Bool = false
    
    init(in rect: CGRect, bodyWidth: CGFloat) {
        self.bodyWidth = bodyWidth
        self.maxX = (rect.maxX / bodyWidth).rounded()
        self.maxY = (rect.maxY / bodyWidth).rounded()
        self.bodyPosition = [SnakeGame.getRandomPositionIn(rect, forBodyWidth: bodyWidth)]
        repeat {
            self.foodPosition = SnakeGame.getRandomPositionIn(rect, forBodyWidth: bodyWidth)
        } while foodPosition == bodyPosition[0]
    }
    
    func changeDirectionWithTranslation(_ translation: CGSize) {
        if abs(translation.width) > abs(translation.height) {
            //Horizontal translation
            if translation.width > 0, direction != .left {
                direction = .right
            } else if translation.width < 0 && direction != .right {
                direction = .left
            }
        } else {
            //Vertical translation
            if translation.height > 0, direction != .up {
                direction = .down
            } else if translation.height < 0 && direction != .down {
                direction = .up
            }
        }
    }
    
    func moveSnake() {
        
        if !isGameOver {
            switch direction {
            case .up:
                bodyPosition[0].y -= 1
            case .left:
                bodyPosition[0].x -= 1
            case .down:
                bodyPosition[0].y += 1
            case .right:
                bodyPosition[0].x += 1
            }
            
            if foodPosition == bodyPosition[0] {
                print("WON")
                repeat {
                    foodPosition = SnakeGame.getRandomPositionIn(CGRect(x: 0, y: 0, width: maxX, height: maxY), forBodyWidth: bodyWidth)
                } while foodPosition == bodyPosition[0]
            }
            
            if bodyPosition[0].x < 0 || bodyPosition[0].x == maxX || bodyPosition[0].y < 0 || bodyPosition[0].y == maxY {
                isGameOver.toggle()
                print("GAMEOVER")
            }
        }
        
        
        
        
    }
    
    enum Direction {
        case up
        case left
        case down
        case right
    }
    
    
    
    
    
    static func getRandomPositionIn(_ rect: CGRect, forBodyWidth bodyWidth: CGFloat) -> CGPoint {
        let x = CGFloat.random(in: 0..<rect.maxX/bodyWidth).rounded()
        let y = CGFloat.random(in: 0..<rect.maxY/bodyWidth).rounded()
        return CGPoint(x: x, y: y)

    }
    
}

