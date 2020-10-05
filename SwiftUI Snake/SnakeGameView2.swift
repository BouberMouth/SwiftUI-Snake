//
//  SnakeGameView2.swift
//  SwiftUI Snake
//
//  Created by Antoine on 21/09/2020.
//

import SwiftUI

struct SnakeGameView2: View {
    
    let bgColor = Color(UIColor(displayP3Red: 158/255, green: 205/255, blue: 156/255, alpha: 1))
    @State var isGamePaused = false
    @State var isGameOver = false
    @State var direction = Direction.right
    @State var bodyPositions: [CGPoint] = [CGPoint(x: 0, y: 0)]
    let snakeSize = 20
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Score: 0")
                    .frame(height: 50)
                Rectangle().fill(bgColor)
                    .frame(width: geo.size.width * 0.95,
                           height: heightForGameIn(geo.size))
                    .offset(x: geo.size.width * 0.025)
                
                HStack {
                    Button(isGamePaused ? "Play" : "Pause") {
                        isGamePaused.toggle()
                        print("PAUSE")
                    }
                    .padding(5)
                    .background(Color.black)
                    .cornerRadius(5)
                    .padding(.trailing, isGamePaused ? 25 : 0)
                    
                    if isGamePaused {
                        Button("Restart") {
                            print("RESTART")
                        }
                        .padding(5)
                        .background(Color.black)
                        .cornerRadius(5)
                        .padding(.leading, 25)
                    }
                }
                .frame(height: 50)
                .foregroundColor(.white)
            }
            .font(.system(size: 30))
        }
    }
    
    func heightForGameIn(_ size: CGSize) -> CGFloat {
        let width = size.width * 0.95
        let cellSize = width / 20
        let availableHeightSpace = size.height - 50 - 50 - 20
        let numberOfRow = Int(availableHeightSpace / cellSize)
        let gameHeight = CGFloat(numberOfRow) * cellSize
        
        return gameHeight
    }
    
    enum Direction: CaseIterable {
        case up
        case left
        case down
        case right
    }
}

struct SnakeGameView2_Previews: PreviewProvider {
    static var previews: some View {
        SnakeGameView2()
    }
}
