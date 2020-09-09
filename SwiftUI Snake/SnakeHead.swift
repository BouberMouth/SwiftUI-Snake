//
//  SnakeHead.swift
//  SwiftUI Snake
//
//  Created by Antoine on 01/09/2020.
//

import SwiftUI

struct SnakeHead: Shape {
    
    func path(in rect: CGRect) -> Path {
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let centerLeft = CGPoint(x: rect.minX, y: rect.midY)
        let centerRight = CGPoint(x: rect.maxX, y: rect.midY)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        
        var p = Path()
        p.move(to: centerLeft)
        p.addLines([
            bottomLeft,
            bottomRight,
            centerRight
        ])
        p.addArc(center: center, radius: rect.height/2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        
        return p
    }
}
