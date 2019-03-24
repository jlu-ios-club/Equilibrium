import SpriteKit
import GameplayKit

public let adaptiveRange : Double = 30
public let bornInitTime : Double = 1800
public let deathInitTime : Double = 2000

public protocol Life {
    var adaptAbility : Double! {get set}
    var bornTime : Double {get}
    var deathTime : Double {get}
    var influence : Double! {get set}
    var kind : Int! {get set}
}

public class FlowerNode: SKSpriteNode,Life {
    public var adaptAbility: Double!
    public var bornTime: Double = bornInitTime
    public var deathTime: Double = deathInitTime
    public var influence: Double!
    public var kind: Int!
    
    public func bornTimeChangeByT(scene : GameScene) -> Void {
        var changeNum : Double = 0
        let level = abs(scene.curTemperature(currentplace: position) - adaptAbility) / adaptiveRange
        if level < 0.3 {
            changeNum = 15
        } else if level < 0.6 {
            changeNum = 12
        } else if level < 1 {
            changeNum = 8
        } else {
            changeNum = 2
        }
        bornTime -= changeNum
    }
    
    public func deathTimeChangeByT(scene : GameScene) -> Void {
        var changeNum : Double = 0
        let level = abs(scene.curTemperature(currentplace: position) - adaptAbility) / adaptiveRange
        if level < 0.3 {
            changeNum = 2
        } else if level < 0.6 {
            changeNum = 3
        } else if level < 1 {
            changeNum = 4
        } else {
            changeNum = 6
        }
        deathTime -= changeNum
    }
    
    convenience init(scene : GameScene, kind : Int, bornPlace : CGPoint) {
        switch kind {
            case 0:
                let texture = SKTexture(imageNamed: "img/BlackFlower.png")
                self.init(texture: texture, color: UIColor.clear, size: CGSize.init(width: GameScene.size * 0.8, height: GameScene.size * 0.8))
                self.adaptAbility = 30
                self.influence = 1
            default:
                let texture = SKTexture(imageNamed: "img/YellowFlower.png")
                self.init(texture: texture, color: UIColor.clear, size: CGSize.init(width: GameScene.size * 0.8, height: GameScene.size * 0.8))
                self.adaptAbility = 60
                self.influence = -1
        }
        self.kind = kind
        self.speed = 0
        
        position = bornPlace
        physicsBody = SKPhysicsBody.init(rectangleOf: size, center: CGPoint(x : 0.5, y : 0.5))
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = flowersCategory
        physicsBody?.collisionBitMask = hAnimalsCategory | flowersCategory
        
        scene.comTemperature += influence
    }
}

public class AnimalNode: SKSpriteNode,Life {
    public var adaptAbility: Double!
    public var bornTime: Double = bornInitTime
    public var deathTime: Double = deathInitTime
    public var influence: Double!
    public var kind: Int!
    
    public func bornTimeChangeByT(scene : GameScene) -> Void {
        bornTime -= 600
    }
    
    public func deathTimeChangeByT(scene : GameScene) -> Void {
        var changeNum : Double = 0
        let level = abs(scene.curTemperature(currentplace: position) - adaptAbility) / adaptiveRange
        if level < 0.3 {
            changeNum = 2
        } else if level < 0.6 {
            changeNum = 3
        } else if level < 1 {
            changeNum = 4
        } else {
            changeNum = 6
        }
        deathTime -= changeNum
    }
    
    convenience init(scene : GameScene, kind : Int, bornPlace : CGPoint) {
        switch kind {
        case 0:
            let texture = SKTexture(imageNamed: "img/HerbivoreAnimal.png")
            self.init(texture: texture, color: UIColor.clear, size: CGSize.init(width: GameScene.size * 0.8, height: GameScene.size * 0.8))
            position = bornPlace
            physicsBody = SKPhysicsBody.init(rectangleOf: size, center: CGPoint(x : 0.5, y : 0.5))
            physicsBody?.allowsRotation = false
            physicsBody?.categoryBitMask = hAnimalsCategory
            physicsBody?.contactTestBitMask = flowersCategory
            physicsBody?.collisionBitMask = hAnimalsCategory | cAnimalsCategory
        default:
            let texture = SKTexture(imageNamed: "img/CarnivoreAnimal.png")
            self.init(texture: texture, color: UIColor.clear, size: CGSize.init(width: GameScene.size * 0.8, height: GameScene.size * 0.8))
            position = bornPlace
            physicsBody = SKPhysicsBody.init(rectangleOf: size, center: CGPoint(x : 0.5, y : 0.5))
            physicsBody?.allowsRotation = false
            physicsBody?.categoryBitMask = cAnimalsCategory
            physicsBody?.contactTestBitMask = hAnimalsCategory
            physicsBody?.collisionBitMask = hAnimalsCategory | cAnimalsCategory
        }
        self.kind = kind
        self.adaptAbility = 45
        self.influence = 2
        
        scene.comTemperature += influence
    }
}
