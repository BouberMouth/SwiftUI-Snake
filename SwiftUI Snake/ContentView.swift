//
//  ContentView.swift
//  SwiftUI Snake
//
//  Created by Antoine on 19/08/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            SnakeGameView(game: SnakeGame(
                            in: CGRect(x: 0, y: 0, width: geo.size.width, height: geo.size.height),
                            bodyWidth: min(geo.size.width, geo.size.height)/5))
        }
        //SnakeHead().aspectRatio(1, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
