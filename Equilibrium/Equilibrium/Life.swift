//
//  Life.swift
//  Equilibrium
//
//  Created by 陆子旭 on 2019/3/20.
//  Copyright © 2019 陆子旭. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

let adaptiveRange : Double = 30

protocol Life {
    var adaptAbility : Double {get}
    var bornTime : Double {get}
    var deathTime : Double {get}
    var influence : Double {get}
    var speed : Double {get}
    var node : SKSpriteNode! {get}
    
    func born() -> CGPoint
    func death() -> Bool
}

class Flower: Life {
    var adaptAbility: Double {
        return 45
    }
    var bornTime: Double = 10
    var deathTime: Double = 12
    var influence: Double {
        return 0
    }
    var speed: Double = 0
    var node : SKSpriteNode!
    
    func bornTimeChangeByT() -> Double {
        let level = abs(GameScene.curTemperature(currentplace: node!.position) - adaptAbility) / adaptiveRange
        if level < 0.3 {
            return 2.5
        } else if level < 0.6 {
            return 1.5
        } else if level < 1 {
            return 0.5
        } else {
            return 0
        }
    }
    
    func deathTimeChangeByT() -> Double {
        let level = abs(GameScene.curTemperature(currentplace: node!.position) - adaptAbility) / adaptiveRange
        if level < 0.3 {
            return 2
        } else if level < 0.6 {
            return 3
        } else if level < 1 {
            return 4
        } else {
            return 6
        }
    }

    func born() -> CGPoint {
        bornTime -= bornTimeChangeByT()
        var place = CGPoint.init(x: 19 * GameScene.size, y: 0)
        if bornTime < 0 {
            let ram = GKRandomDistribution.init(lowestValue: -Int(1.5 * Double(GameScene.size)), highestValue: Int(1.5 * Double(GameScene.size)))
            let positionY : Double = Double(ram.nextInt())
            var positionX = sqrt(1.5 * Double(GameScene.size) * 1.5 * Double(GameScene.size) - positionY * positionY)
            if ram.nextBool() {
                positionX = -positionX
            }
            place.x = CGFloat(positionX)
            place.y = CGFloat(positionY)
        }
        return place
    }
    
    func death() -> Bool {
        deathTime -= deathTimeChangeByT()
        if deathTime < 0 {
            return true
        }
        return false
    }
}

class Bflower: Flower {
    override var adaptAbility: Double {
        return 35
    }
    override var influence: Double {
        return 1
    }
    
    init(bornplace : CGPoint) {
        
    }
}

//class Wflower: Flower {
//    var adaptability: Double = 50
//    var borntime: Double = 5
//    var influence: Double = -1
//    var speed: Double = 0
//}

//protocol Animal: Life {
//
//}
//
//class Hanimal: Animal {
//
//}
//
//class Canimal: Animal {
//
//}
