//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

/*:
 # Equilibrium
 
 ## What is it?
 
 It is a game which can simulate the ecological equilibrium system in our nature.
 
 ## How does it work?
 
 In this system, the screen represents a land, and the temperature of it gets lower along with the increase of the latitude ( imagine the land is located in the Southern Hemisphere ). To simulate the effect of producers, two kinds of flowers, the black ones and the yellow ones, are constructed, and their growth are affected by temperature. The black flowers grow well in the cold environment and absorb heat, while the yellow ones just act the opposite. Besides, herbivores and carnivores are added too. The herbivores feed on the flowers while the carnivores feed on them, which is consistent with the common sense. By running the system under which all of the objects interact with each other randomly, we create a simulated ecological system which is likely to achieve ecological balance or be destroyed shortly after.
 
 ## What can we do to intervene the process?
 
 We can add objects in the init funtion to simulate different condition. At the same time, we can also change some parameters such as the value in "Life.swift", leading to more interesting situation.
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
