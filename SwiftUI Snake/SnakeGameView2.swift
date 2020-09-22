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
    
    var body: some View {
        GeometryReader { geo in
            VStack() {
                Text("Score: 0").frame(height: 50)
                Rectangle().fill(bgColor)
                    .frame(width: geo.size.width * 0.95,
                           height: heightForGameIn(geo.size))
                    .offset(x: geo.size.width * 0.025)
                
                HStack {
                    Button(isGamePaused ? "Play" : "Pause") {
                        isGamePaused.toggle()
                        print("PAUSE")
                    }
                    .padding()
                    .background(Color.red)
                    .cornerRadius(5)
                    
                    if isGamePaused {
                        Button("Restart") {
                            print("RESTART")
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(5)
                    }
                }.frame(height: 50)
            }
        }
    }
    
    func heightForGameIn(_ size: CGSize) -> CGFloat {
        let width = size.width * 0.95
        let cellSize = width / 20
        let availableHeightSpace = size.height - 50 - 50
        let numberOfRow = Int(availableHeightSpace / cellSize)
        let gameHeight = CGFloat(numberOfRow) * cellSize
        
        return gameHeight
    }
}

struct SnakeGameView2_Previews: PreviewProvider {
    static var previews: some View {
        SnakeGameView2()
    }
}
