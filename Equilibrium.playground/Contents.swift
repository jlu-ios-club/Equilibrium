//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

/*:
 # Equilibrium
 
 ## What is it?
 
 It is a game which can simulate the ecological equilibrium system in our nature.
 
 ## What does it show?
 
 In this system, we can find the land is colder in the lower part. And there are two kinds of flowers as producers. They are affected by temperature. The black flowers grow well in the cold environment and absorb heat, the yellow ones the opposite. In addition, I add the herbivore and the carnivore. Running through the objects in every possible combination, we can create an ecological equilibrium system or ruin the land.
 
 
 ## How can we play?
 
 We can add objects in the init funtion to simulate different condition. At the same time, we can change the value in "Life.swift" to show more interesting situation.
 */

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 600, height: 900))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
