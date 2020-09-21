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
            SnakeGameView2()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
