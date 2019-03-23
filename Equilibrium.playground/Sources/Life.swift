import SpriteKit
import GameplayKit

public let adaptiveRange : Double = 30
public let bornInitTime : Double = 1000
public let deathInitTime : Double = 1200

public protocol Life {
    var adaptAbility : Double {get}
    var bornTime : Double {get}
    var deathTime : Double {get}
    var influence : Double {get}
    var speed : Double {get}
    var node : SKSpriteNode! {get}
    
    func born(scene : GameScene) -> CGPoint
    func death(scene : GameScene) -> Bool
}

public class Flower: Life {
    public var adaptAbility: Double {
        return 45
    }
    public var bornTime: Double = bornInitTime
    public var deathTime: Double = deathInitTime
    public var influence: Double {
        return 0
    }
    public var speed: Double = 0
    public var node : SKSpriteNode!
    
    public func bornTimeChangeByT(scene : GameScene) -> Double {
        let level = abs(scene.curTemperature(currentplace: node!.position) - adaptAbility) / adaptiveRange
        if level < 0.3 {
            return 15
        } else if level < 0.6 {
            return 12
        } else if level < 1 {
            return 8
        } else {
            return 2
        }
    }
    
    public func deathTimeChangeByT(scene : GameScene) -> Double {
        let level = abs(scene.curTemperature(currentplace: node!.position) - adaptAbility) / adaptiveRange
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
    
    public func born(scene : GameScene) -> CGPoint {
        bornTime -= bornTimeChangeByT(scene: scene)
        var place = CGPoint.init(x: 10 * GameScene.size, y: 0)
        if bornTime < 0 {
            let ram = GKRandomDistribution.init(lowestValue: -Int(1.3 * Double(GameScene.size)), highestValue: Int(1.3 * Double(GameScene.size)))
            let positionY : Double = Double(ram.nextInt())
            var positionX = sqrt(1.3 * Double(GameScene.size) * 1.3 * Double(GameScene.size) - positionY * positionY)
            if ram.nextBool() {
                positionX = -positionX
            }
            place.x = CGFloat(positionX)
            place.y = CGFloat(positionY)
        }
        return place
    }
    
    public func death(scene : GameScene) -> Bool {
        deathTime -= deathTimeChangeByT(scene: scene)
        if deathTime < 0 {
            return true
        }
        return false
    }
}

public class Bflower: Flower {
    public override var adaptAbility: Double {
        return 35
    }
    public override var influence: Double {
        return 1
    }
    
    init(bornPlace : CGPoint) {
        super.init()
        
        node = SKSpriteNode.init(imageNamed: "img/BlackFlower.png")
        node.size.height = GameScene.size * 4 / 5
        node.size.width = GameScene.size * 4 / 5
        node.position = bornPlace
        node.physicsBody = SKPhysicsBody.init(rectangleOf: node.size, center: CGPoint(x : 0.5, y : 0.5))
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = flowersCategory
    }
}

public class Yflower: Flower {
    public override var adaptAbility: Double {
        return 55
    }
    public override var influence: Double {
        return -1
    }
    
    init(bornPlace : CGPoint) {
        super.init()
        
        node = SKSpriteNode.init(imageNamed: "img/YellowFlower.png")
        node.size.height = GameScene.size * 4 / 5
        node.size.width = GameScene.size * 4 / 5
        node.position = bornPlace
        node.physicsBody = SKPhysicsBody.init(rectangleOf: node.size, center: CGPoint(x : 0.5, y : 0.5))
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = flowersCategory
    }
}

public class Animal: Life {
    public var adaptAbility: Double = 45
    public var bornTime: Double = bornInitTime
    public var deathTime: Double = deathInitTime
    public var influence: Double = 2
    public var speed: Double {
        return 0
    }
    public var node : SKSpriteNode!
    
    public func bornTimeChange() -> Void {
        bornTime -= 300
    }

    public func deathTimeChange() -> Void {
        deathTime -= 1
    }

    public func born(scene : GameScene) -> CGPoint {
        var place = CGPoint.init(x: 10 * GameScene.size, y: 0)
        if bornTime < 0 {
            let ram = GKRandomDistribution.init(lowestValue: -Int(1 * Double(GameScene.size)), highestValue: Int(1 * Double(GameScene.size)))
            let positionY : Double = Double(ram.nextInt())
            var positionX = sqrt(1 * Double(GameScene.size) * 1 * Double(GameScene.size) - positionY * positionY)
            if ram.nextBool() {
                positionX = -positionX
            }
            place.x = CGFloat(positionX)
            place.y = CGFloat(positionY)
        }
        return place
    }

    public func death(scene : GameScene) -> Bool {
        if deathTime < 0 {
            return true
        }
        return false
    }
    
    public func move(place : CGPoint) -> Void {
        var placeTemp = place
        placeTemp.x = placeTemp.x - node.position.x
        placeTemp.y = placeTemp.y - node.position.y
        let splaceTemp = sqrt(placeTemp.x * placeTemp.x + placeTemp.y * placeTemp.y)
        node.position.x = placeTemp.x / splaceTemp * CGFloat(speed) + node.position.x
        node.position.y = placeTemp.y / splaceTemp * CGFloat(speed) + node.position.y
    }
}

public class Hanimal: Animal {
    public override var speed: Double {
        return 3
    }

    init(bornPlace : CGPoint) {
        super.init()

        node = SKSpriteNode.init(imageNamed: "img/HerbivoreAnimal.png")
        node.size.height = GameScene.size * 4 / 5
        node.size.width = GameScene.size * 4 / 5
        node.position = bornPlace
        node.physicsBody = SKPhysicsBody.init(rectangleOf: node.size, center: CGPoint(x : 0.5, y : 0.5))
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = hAnimalsCategory
        node.physicsBody?.contactTestBitMask = flowersCategory
    }
}

public class Canimal: Animal {
    public override var speed: Double {
        return 6
    }
    
    init(bornPlace : CGPoint) {
        super.init()

        node = SKSpriteNode.init(imageNamed: "img/CarnivoreAnimal.png")
        node.size.height = GameScene.size * 4 / 5
        node.size.width = GameScene.size * 4 / 5
        node.position = bornPlace
        node.physicsBody = SKPhysicsBody.init(rectangleOf: node.size, center: CGPoint(x : 0.5, y : 0.5))
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = cAnimalsCategory
        node.physicsBody?.contactTestBitMask = hAnimalsCategory
    }
}
