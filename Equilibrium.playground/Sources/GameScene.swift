import SpriteKit

public class GameScene: SKScene {
    
    // Get label node from scene and store it for use later
    private var comTemperatureLabel : SKLabelNode!
    private var bFlowersLabel : SKLabelNode!
    private var yFlowersLabel : SKLabelNode!
    
    // Size
    static let size : CGFloat = 50
    
    // Temperature
    var comTemperature : Double = 45
    
    public func curTemperature(currentplace: CGPoint) -> Double {
        return comTemperature + Double(currentplace.y / 20)
    }
    
    // Node
    var flowersArr = [Flower]()
    var bFlowersNum : Int = 0
    var yFlowersNum : Int = 0
    
    func isLegal(bornPlace: CGPoint) -> Bool {
        if bornPlace.x > GameScene.size * 5  || bornPlace.x < GameScene.size * -5 ||
            bornPlace.y > GameScene.size * 7.5 || bornPlace.y < GameScene.size * -7.5 {
            return false
        }
        for flowers in flowersArr {
            let xplace = flowers.node.position.x - bornPlace.x
            let yplace = flowers.node.position.y - bornPlace.y
            if xplace > -GameScene.size && xplace < GameScene.size &&
                yplace > -GameScene.size && yplace < GameScene.size {
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

    // Scene
    public override func didMove(to view: SKView) {
        comTemperatureLabel = childNode(withName: "//comTemperature") as? SKLabelNode
        bFlowersLabel = childNode(withName: "//bFlowers") as? SKLabelNode
        yFlowersLabel = childNode(withName: "//yFlowers") as? SKLabelNode
        
        var node1 : Bflower!
        var node2 : Yflower!
        
        for i in 1...3 {
            node1 = Bflower.init(bornPlace: CGPoint.init(x: -200 + i * 100, y: 200))
            self.addChild(node1.node)
            self.flowersArr.append(node1)
            comTemperature += node1.influence
            
            node2 = Yflower.init(bornPlace: CGPoint.init(x: -200 + i * 100, y: -200))
            self.addChild(node2.node)
            self.flowersArr.append(node2)
            comTemperature += node2.influence
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        switch gameStatus {
            case .idle:
                return
            case .running:
                // Change  comTemperature
                comTemperatureLabel.text = "comTemperature:\(comTemperature)"
                bFlowersLabel.text = "bFlowers:\(bFlowersNum)"
                yFlowersLabel.text = "bFlowers:\(yFlowersNum)"
                
                // Called before each frame is rendered
                for (index,fNode) in flowersArr.enumerated() {
                    if fNode.death(scene: self) {
                        fNode.node.removeFromParent()
                        flowersArr.remove(at: index)
                        comTemperature -= fNode.influence
                        continue
                    }
                    
                    var placeTemp : CGPoint = fNode.born(scene: self)
                    placeTemp.x += fNode.node.position.x
                    placeTemp.y += fNode.node.position.y
                    if isLegal(bornPlace: placeTemp) {
                        let nodeTemp : Flower!
                        if fNode is Bflower {
                            nodeTemp = Bflower.init(bornPlace: placeTemp)
                        } else {
                            nodeTemp = Yflower.init(bornPlace: placeTemp)
                        }
                        self.addChild(nodeTemp.node)
                        self.flowersArr.append(nodeTemp)
                        comTemperature += nodeTemp.influence
                        fNode.bornTime += bornInitTime
                    }
                }
                
                // count node
                var tempNum = 0
                for fNode in flowersArr {
                    if fNode is Bflower {
                        tempNum += 1
                    }
                }
                bFlowersNum = tempNum
                yFlowersNum = flowersArr.count - tempNum
            case .over:
                return
        }
    }
}
