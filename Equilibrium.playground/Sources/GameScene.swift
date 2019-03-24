import SpriteKit
import GameplayKit

// Physics
let flowersCategory: UInt32 = 0x1 << 0
let hAnimalsCategory: UInt32 = 0x1 << 1
let cAnimalsCategory: UInt32 = 0x1 << 2

public class GameScene: SKScene,SKPhysicsContactDelegate {
    
    // Get label node from scene and store it for use later
    private var comTemperatureLabel : SKLabelNode!
    private var bFlowersLabel : SKLabelNode!
    private var yFlowersLabel : SKLabelNode!
    private var hAnimalsLabel : SKLabelNode!
    private var cAnimalsLabel : SKLabelNode!
    
    // Size
    static let size : CGFloat = 50
    
    // range
    static let maxNum : Int = 70
    
    // Temperature
    var comTemperature : Double = 45
    
    public func curTemperature(currentplace: CGPoint) -> Double {
        return comTemperature + Double(currentplace.y / 20)
    }
    
    // Node
    var bFlowersNum : Int = 0
    var yFlowersNum : Int = 0
    var hAnimalsNum : Int = 0
    var cAnimalsNum : Int = 0
    
    func isIn(bornPlace: CGPoint) -> Bool {
        if bornPlace.x > GameScene.size * 5  || bornPlace.x < GameScene.size * -5 ||
            bornPlace.y > GameScene.size * 7.5 || bornPlace.y < GameScene.size * -7.5 {
            return false
        }
        return true
    }
    
    func isOut(bornPlace: CGPoint) -> Bool {
        for child in children {
            let xplace = child.position.x - bornPlace.x
            let yplace = child.position.y - bornPlace.y
            if xplace > -GameScene.size * 1.2 && xplace < GameScene.size * 1.2 &&
                yplace > -GameScene.size * 1.2 && yplace < GameScene.size * 1.2 {
                return false
            }
        }
        return true
    }
    
    // GameStatus
    enum GameStatus {
        case idle
        case running
        case over
    }
    
    func shuffle() {
        gameStatus = .idle
    }
    
    func startGame() {
        gameStatus = .running
    }
    
    func gameOver()  {
        gameStatus = .over
    }
    
    var gameStatus: GameStatus = .idle
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case .idle:
            startGame()
        case .running:
            gameOver()
        case .over:
            shuffle()
        }
    }

    // Init
    public func initGame1() -> Void {
        for i in 1...3 {
            let temp = FlowerNode.init(scene: self, kind: 0, bornPlace: CGPoint.init(x: -200 + 100 * i, y: 0))
            addChild(temp)
        }
    }
    
    public func initGame2() -> Void {
        for i in 1...3 {
            let temp1 = FlowerNode.init(scene: self, kind: 0, bornPlace: CGPoint.init(x: -225 + 100 * i, y: 0))
            addChild(temp1)
            let temp2 = FlowerNode.init(scene: self, kind: 1, bornPlace: CGPoint.init(x: -175 + 100 * i, y: 0))
            addChild(temp2)
        }
    }
    
    public func initGame3() -> Void {
        for i in 1...5 {
            let temp1 = FlowerNode.init(scene: self, kind: 0, bornPlace: CGPoint.init(x: -300 + 100 * i, y: 200))
            addChild(temp1)
            let temp2 = FlowerNode.init(scene: self, kind: 1, bornPlace: CGPoint.init(x: -300 + 100 * i, y: -200))
            addChild(temp2)
        }
        
        let tempp1 = AnimalNode.init(scene: self, kind: 0, bornPlace: CGPoint.init(x: 100, y: 0))
        addChild(tempp1)
        let tempp2 = AnimalNode.init(scene: self, kind: 0, bornPlace: CGPoint.init(x: -100, y: 0))
        addChild(tempp2)
    }
    
    public func initGame4() -> Void {
        for i in 1...5 {
            let temp1 = FlowerNode.init(scene: self, kind: 0, bornPlace: CGPoint.init(x: -300 + 100 * i, y: 200))
            addChild(temp1)
            let temp2 = FlowerNode.init(scene: self, kind: 1, bornPlace: CGPoint.init(x: -300 + 100 * i, y: -200))
            addChild(temp2)
        }
        
        let tempp1 = AnimalNode.init(scene: self, kind: 0, bornPlace: CGPoint.init(x: 200, y: 0))
        addChild(tempp1)
        let tempp2 = AnimalNode.init(scene: self, kind: 0, bornPlace: CGPoint.init(x: -200, y: 0))
        addChild(tempp2)
        let tempp3 = AnimalNode.init(scene: self, kind: 1, bornPlace: CGPoint.init(x: 0, y: 0))
        addChild(tempp3)
    }
    
    // Physics
    public func didBegin(_ contact: SKPhysicsContact) {
        if gameStatus != .running {
            return
        }
        var bodyA : SKPhysicsBody
        var bodyB : SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyA = contact.bodyA
            bodyB = contact.bodyB
        } else {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        if bodyA.categoryBitMask == flowersCategory && bodyB.categoryBitMask == hAnimalsCategory {
            bodyA.node?.removeFromParent()
            bodyA.node?.physicsBody = nil
            bodyA.node?.removeAllActions()
            let hchild = bodyB.node! as! AnimalNode
            hchild.bornTimeChangeByT(scene: self)
        } else if bodyA.categoryBitMask == hAnimalsCategory && bodyB.categoryBitMask == cAnimalsCategory {
            bodyA.node?.removeFromParent()
            bodyA.node?.physicsBody = nil
            bodyA.node?.removeAllActions()
            let hchild = bodyB.node! as! AnimalNode
            hchild.bornTimeChangeByT(scene: self)
        }
    }
    
    // Scene
    public override func didMove(to view: SKView) {
        // Set Scene physics
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity.dy = 0
        
        // Label
        comTemperatureLabel = childNode(withName: "//comTemperature") as? SKLabelNode
        bFlowersLabel = childNode(withName: "//bFlowers") as? SKLabelNode
        yFlowersLabel = childNode(withName: "//yFlowers") as? SKLabelNode
        hAnimalsLabel = childNode(withName: "//hAnimals") as? SKLabelNode
        cAnimalsLabel = childNode(withName: "//cAnimals") as? SKLabelNode
        
        initGame4()
    }
    
    public override func update(_ currentTime: TimeInterval) {
        switch gameStatus {
        case .idle:
            return
        case .running:
            // Change Label
            comTemperatureLabel.text = "comTemperature:\(comTemperature)"
            bFlowersLabel.text = "bFlowers:\(bFlowersNum)"
            yFlowersLabel.text = "yFlowers:\(yFlowersNum)"
            hAnimalsLabel.text = "hAnimals:\(hAnimalsNum)"
            cAnimalsLabel.text = "cAnimals:\(cAnimalsNum)"
            
            // Count node
            bFlowersNum = 0
            yFlowersNum = 0
            hAnimalsNum = 0
            cAnimalsNum = 0
            
            let ram = GKRandomDistribution.init(lowestValue: -Int(1.3 * Double(GameScene.size)), highestValue: Int(1.3 * Double(GameScene.size)))
            var tempPlaceX : CGFloat!
            var tempPlaceY : CGFloat!
            for child in children {
                if child is FlowerNode {
                    let fchild = child as! FlowerNode
                    
                    fchild.deathTimeChangeByT(scene: self)
                    if fchild.deathTime < 0 {
                        fchild.removeFromParent()
                        fchild.physicsBody = nil
                        fchild.removeAllActions()
                    }
                    
                    fchild.bornTimeChangeByT(scene: self)
                    if fchild.bornTime < 0 {
                        tempPlaceY = CGFloat(ram.nextInt())
                        tempPlaceX = sqrt(1.3 * GameScene.size * 1.3 * GameScene.size - tempPlaceY * tempPlaceY)
                        if ram.nextBool() {
                            tempPlaceX = -tempPlaceX
                        }
                        tempPlaceX += fchild.position.x
                        tempPlaceY += fchild.position.y

                        if isIn(bornPlace: CGPoint.init(x: tempPlaceX, y: tempPlaceY)) && isOut(bornPlace: CGPoint.init(x: tempPlaceX, y: tempPlaceY)) {
                            addChild(FlowerNode.init(scene: self, kind: fchild.kind, bornPlace: CGPoint.init(x: tempPlaceX, y: tempPlaceY)))
                            fchild.bornTime += bornInitTime
                        }
                    }
                    switch fchild.kind {
                    case 0:
                        bFlowersNum += 1
                    case 1:
                        yFlowersNum += 1
                    default:
                        return
                    }
                } else if child is AnimalNode {
                    let achild = child as! AnimalNode
                    
                    achild.deathTimeChangeByT(scene: self)
                    if achild.deathTime < 0 {
                        achild.removeFromParent()
                        achild.physicsBody = nil
                        achild.removeAllActions()
                    }
                    
                    if achild.bornTime < 0 {
                        tempPlaceY = CGFloat(ram.nextInt())
                        tempPlaceX = sqrt(1.3 * GameScene.size * 1.3 * GameScene.size - tempPlaceY * tempPlaceY)
                        if ram.nextBool() {
                            tempPlaceX = -tempPlaceX
                        }
                        tempPlaceX += achild.position.x
                        tempPlaceY += achild.position.y
                        
                        if isIn(bornPlace: CGPoint.init(x: tempPlaceX, y: tempPlaceY)) {
                            addChild(AnimalNode.init(scene: self, kind: achild.kind, bornPlace: CGPoint.init(x: tempPlaceX, y: tempPlaceY)))
                            achild.bornTime += bornInitTime
                        }
                    }
                    switch achild.kind {
                    case 0:
                        hAnimalsNum += 1
                        if !achild.hasActions() {
                            var moveToPlace : CGPoint = CGPoint.init(x: 0, y: 0)
                            for tchild in children {
                                if tchild is FlowerNode {
                                    moveToPlace = tchild.position
                                    break
                                }
                            }
                            let moveToEat = SKAction.move(to: moveToPlace, duration: 1)
                            moveToEat.speed = 0.5
                            achild.run(moveToEat)
                        }
                    case 1:
                        cAnimalsNum += 1
                        if !achild.hasActions() {
                            var moveToPlace : CGPoint = CGPoint.init(x: 0, y: 0)
                            for tchild in children {
                                if tchild is AnimalNode {
                                    let ttchild = tchild as! AnimalNode
                                    if ttchild.kind == 0 {
                                        moveToPlace = tchild.position
                                        break
                                    }
                                }
                            }
                            let moveToEat = SKAction.move(to: moveToPlace, duration: 1)
                            moveToEat.speed = 0.7
                            achild.run(moveToEat)
                        }
                    default:
                        return
                    }
                }
            }
        case .over:
            return
        }
    }
}
