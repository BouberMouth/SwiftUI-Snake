//
//  SnakeGame.swift
//  SwiftUI Snake
//
//  Created by Antoine on 19/08/2020.
//

import SwiftUI
import AVFoundation
import Speech

class SnakeGame: ObservableObject {
    
    let gameBoard: CGRect
    let bodyWidth: CGFloat
    @Published var bodyPosition: [CGPoint]
    @Published var foodPosition: CGPoint
    @Published var poisonPosition: CGPoint?
    var poisonCounter: Int = 3
    var maxX: CGFloat { return gameBoard.maxX - 1 }
    var maxY: CGFloat { return gameBoard.maxY - 1 }
    var direction: Direction = .down
    @Published var isGameOver: Bool = false

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
                                /*/_____________________________________BUG TO FIX
                                var indexOfHit = 3
                                for point in bodyPosition[1..<bodyPosition.count] {
                                    if point.x == bodyPosition[0].x && point.y == bodyPosition[0].y {
                                        indexOfHit = bodyPosition.firstIndex(of: point)!
                                        print("HIT: \(indexOfHit)")
                                    }
                                }
                                bodyPosition.removeSubrange(indexOfHit..<bodyPosition.count)
                                *///_______________________________
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
            
            print(bodyPosition.count)
            if foodPosition == bodyPosition[0] {
                playSound(fileName: "snakehit", withExtension: "mp3")
                bodyPosition.append(bodyPosition[0])
                repeat {
                    foodPosition = SnakeGame.getRandomPositionIn(gameBoard)
                } while bodyPosition.contains(foodPosition)
                
                if poisonPosition != nil {
                    poisonPosition = nil
                    poisonCounter = Int.random(in: 2..<5)
                } else {
                    poisonCounter -= 1
                }
                
                if poisonCounter == 0 {
                    repeat {
                        poisonPosition = SnakeGame.getRandomPositionIn(gameBoard)
                    } while bodyPosition.contains(poisonPosition!) || poisonPosition! == foodPosition
                }
            }
            
            if bodyPosition[0] == poisonPosition {
                print("DEAD BY BOMB")
                isGameOver = true
            }
            
            
        }
    }

    
    var audioPlayer: AVAudioPlayer?
    func playSound(fileName: String, withExtension fileExtension: String) {
        #if targetEnvironment(simulator)
        print("Unable to play sound with app running on the simulator")
        return
        #else
        if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.setVolume(0.1, fadeDuration: 0.2)
                audioPlayer?.play()
            } catch {
                print("Unable to play \(fileName).\(fileExtension). ERROR: \(error)")
            }
        } else {
            print("ERROR: Unable to find the file \(fileName).\(fileExtension)")
        }
        #endif
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
