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
    let maxX: CGFloat
    let maxY: CGFloat
    
    init(in rect: CGRect, bodyWidth: CGFloat) {
        self.bodyWidth = bodyWidth
        self.maxX = rect.maxX
        self.maxY = rect.maxY
        self.bodyPosition = [SnakeGame.getRandomPositionIn(rect, forBodyWidth: bodyWidth)]
    }
    
    func addX() {
        bodyPosition[0].x += 1
    }
    
    
    
    static func getRandomPositionIn(_ rect: CGRect, forBodyWidth bodyWidth: CGFloat) -> CGPoint {
        let x = CGFloat.random(in: 0..<rect.maxX/bodyWidth).rounded()
        let y = CGFloat.random(in: 0..<rect.maxY/bodyWidth).rounded()
        return CGPoint(x: x, y: y)

    }
    
}

