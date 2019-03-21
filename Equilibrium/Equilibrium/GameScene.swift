//
//  GameScene.swift
//  Equilibrium
//
//  Created by 陆子旭 on 2019/3/19.
//  Copyright © 2019 陆子旭. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    // GameStatus
    enum GameStatus {
        case idle
        case running
        case over
    }
    
    func shuffle()  {
        gameStatus = .idle
    }
    
    func startGame()  {
        gameStatus = .running
    }
    
    func gameOver()  {
        gameStatus = .over
    }
    
    var gameStatus: GameStatus = .idle
    
    // size
    static let size = 100
    
    // temperature
    static var comTemperature : Double = 45
    
    static func curTemperature(currentplace: CGPoint) -> Double {
        return comTemperature + Double(currentplace.x / 20)
    }
    
    
    // NodeStatus
    // born place is legal?
    func isLegal(bornplace: CGPoint) -> Bool {
        if bornplace.x > 900 || bornplace.x < -900 ||
           bornplace.y > 600 || bornplace.y < -600 {
            return false
        }
        for nodes in flowersNodeArr {
            let xplace = nodes.position.x - bornplace.x
            let yplace = nodes.position.y - bornplace.y
            if xplace > 100 && xplace < -100 &&
                yplace > 100 && yplace < -100 {
                return false
            }
        }
        return true
    }
    
    var bflowersArr = [Bflower]()
    
    override func sceneDidLoad() {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case .idle:
            startGame()
        case .running:
            gameOver()
        case .over:
            shuffle()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        switch gameStatus {
        case .idle:
            return
        case .running:
            for bflower in bflowersArr {
                
                }
            }
        case .over:
            return
        }
    }
}
