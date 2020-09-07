//
//  SnakeGame.swift
//  SwiftUI Snake
//
//  Created by Antoine on 19/08/2020.
//

import SwiftUI
import AVFoundation

class SnakeGame: ObservableObject {
    
    let gameBoard: CGRect
    let bodyWidth: CGFloat
    @Published var bodyPosition: [CGPoint]
    @Published var foodPosition: CGPoint
    var maxX: CGFloat { return gameBoard.maxX - 1 }
    var maxY: CGFloat { return gameBoard.maxY - 1 }
    var direction: Direction = .down
    @Published var isGameOver: Bool = false
    var player: AVAudioPlayer?
    
    init(in rect: CGRect, bodyWidth: CGFloat) {
        self.bodyWidth = bodyWidth
        self.gameBoard = SnakeGame.findBestFittedBoardIn(rect, withBodyWidth: bodyWidth)
        self.bodyPosition = [SnakeGame.getRandomPositionIn(gameBoard)]
        repeat {
            self.foodPosition = SnakeGame.getRandomPositionIn(gameBoard)
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
                if bodyPosition[0].y == 0 {
                    isGameOver.toggle()
                    print("GAMEOVER")
                } else {
                    for i in bodyPosition.reversedIndices() {
                        if i != 0 {
                            bodyPosition[i] = bodyPosition[i-1]
                        } else {
                            bodyPosition[i].y -= 1
                            if bodyPosition[1..<bodyPosition.count].contains(bodyPosition[0]) {
                                isGameOver.toggle()
                            }
                        }
                        
                    }
                }
            case .left:
                if bodyPosition[0].x == 0 {
                    isGameOver.toggle()
                    print("GAMEOVER")
                } else {
                    for i in bodyPosition.reversedIndices() {
                        if i != 0 {
                            bodyPosition[i] = bodyPosition[i-1]
                        } else {
                            bodyPosition[i].x -= 1
                            if bodyPosition[1..<bodyPosition.count].contains(bodyPosition[0]) {
                                isGameOver.toggle()
                            }
                        }
                    }
                }
            case .down:
                if bodyPosition[0].y == maxY {
                    isGameOver.toggle()
                    print("GAMEOVER")
                } else {
                    for i in bodyPosition.reversedIndices() {
                        if i != 0 {
                            bodyPosition[i] = bodyPosition[i-1]
                        } else {
                            bodyPosition[i].y += 1
                            if bodyPosition[1..<bodyPosition.count].contains(bodyPosition[0]) {
                                isGameOver.toggle()
                            }
                        }
                    }
                }
            case .right:
                if bodyPosition[0].x == maxX {
                    isGameOver.toggle()
                    print("GAMEOVER")
                } else {
                    for i in bodyPosition.reversedIndices() {
                        if i != 0 {
                            bodyPosition[i] = bodyPosition[i-1]
                        } else {
                            bodyPosition[i].x += 1
                            if bodyPosition[1..<bodyPosition.count].contains(bodyPosition[0]) {
                                isGameOver.toggle()
                            }
                        }
                    }
                }
            }
            
            if foodPosition == bodyPosition[0] {
                playSound()
                bodyPosition.append(bodyPosition[0])
                //addToTail()
                repeat {
                    foodPosition = SnakeGame.getRandomPositionIn(gameBoard)
                } while foodPosition == bodyPosition[0]
            }
        }
        
//        print("BOARD -> \(gameBoard.maxX), \(gameBoard.maxY)")
//        print("FOOD -> \(foodPosition), SNAKE -> \(bodyPosition[0])\n")
//        print("GAME OVER ? -> \(isGameOver)")
    }
    
    func addToTail() {
        switch direction {
        case .up:
            bodyPosition.append(CGPoint(x: bodyPosition.last!.x,
                                        y: bodyPosition.last!.y + 1))
        case .left:
            bodyPosition.append(CGPoint(x: bodyPosition.last!.x - 1,
                                        y: bodyPosition.last!.y))
        case .down:
            bodyPosition.append(CGPoint(x: bodyPosition.last!.x,
                                        y: bodyPosition.last!.y - 1))
        case .right:
            bodyPosition.append(CGPoint(x: bodyPosition.last!.x + 1,
                                                        y: bodyPosition.last!.y))
        }
    }
    
    var audioPlayer: AVAudioPlayer?
    func playSound() {
        if let path = Bundle.main.path(forResource: "snakehit", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("ERRRRRRRRROR: \(error)")
            }
        }
    }
    
    func playSound1() {
        guard let url = Bundle.main.url(forResource: "snakehit", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    enum Direction {
        case up
        case left
        case down
        case right
    }
    
    static func getRandomPositionIn(_ rect: CGRect) -> CGPoint {
        return CGPoint(x: CGFloat(Int(CGFloat.random(in: 0..<rect.maxX))),
                       y: CGFloat(Int(CGFloat.random(in: 0..<rect.maxY))))
    }
    
    static func findBestFittedBoardIn(_ rect: CGRect, withBodyWidth bodyWidth: CGFloat) -> CGRect {
        let width = CGFloat(Int(rect.width / bodyWidth))
        let height = CGFloat(Int(rect.height / bodyWidth))
        return CGRect(x: 0,
                      y: 0,
                      width: width,
                      height: height
        )
    }
    
    func reset() {
        bodyPosition = [SnakeGame.getRandomPositionIn(gameBoard)]
        repeat {
            self.foodPosition = SnakeGame.getRandomPositionIn(gameBoard)
        } while foodPosition == bodyPosition[0]
        isGameOver = false
    }
    
}


struct Position: Identifiable, Equatable {
    
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs == rhs
    }
    
    var id: UUID = UUID()
    var point: CGPoint
}


extension Collection {
    func reversedIndices() -> [Int] {
        var arr = [Int]()
        for i in 0..<count {
            arr.append(i)
        }
        return arr.reversed()
    }
}
