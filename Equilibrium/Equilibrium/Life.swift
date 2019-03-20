//
//  Life.swift
//  Equilibrium
//
//  Created by 陆子旭 on 2019/3/20.
//  Copyright © 2019 陆子旭. All rights reserved.
//

import Foundation
import SpriteKit

let adaptiverange : Double = 30

protocol Life {
    var adaptability : Double {get}
    var borntime : Double {get}
    var deathtime : Double {get}
    var influence : Double {get}
    var speed : Double {get}
    
    func born(currentscene : GameScene) -> CGPoint
}

protocol Flower: Life {
    
}

class Bflower: Flower {
    var adaptability: Double = 40
    var borntime: Double = 5
    var influence: Double = 1
    var speed: Double = 0
    
    func born(currentscene : GameScene) -> CGPoint {
        let bflowers = SKShapeNode()
        bflowers.path = CGPath(roundedRect: CGRect(x:-2, y:-4, width:4, height:8),
                           cornerWidth: 2, cornerHeight: 4, transform: nil)
        bflowers.strokeColor = SKColor.white
        bflowers.fillColor = SKColor.brown
        //获取场景宽，高
        let w = currentscene.size.width
        let h = currentscene.size.height
        //随机出现在场景的xy位置
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: h)
        //设置陨石的位置
        bflowers.position = CGPoint(x:x,y:y)
        //设置陨石的name属性
        bflowers.name = "bflowers"
        //给陨石设置物理体
        bflowers.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        //物理体允许检测碰撞
        bflowers.physicsBody?.usesPreciseCollisionDetection = true
        //场景加入陨石
        currentscene.addChild(bflowers)
        //同时添加到数组中
        currentscene.bflowersArr.append(bflowers)
    }
}

class Wflower: Flower {
    var adaptability: Double = 50
    var borntime: Double = 5
    var influence: Double = -1
    var speed: Double = 0
    
    func born(currentscene : GameScene) -> Void {
        let bflowers = SKShapeNode()
        bflowers.path = CGPath(roundedRect: CGRect(x:-2, y:-4, width:4, height:8),
                               cornerWidth: 2, cornerHeight: 4, transform: nil)
        bflowers.strokeColor = SKColor.white
        bflowers.fillColor = SKColor.brown
        //获取场景宽，高
        let w = currentscene.size.width
        let h = currentscene.size.height
        //随机出现在场景的xy位置
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: h)
        //设置陨石的位置
        bflowers.position = CGPoint(x:x,y:y)
        //设置陨石的name属性
        bflowers.name = "bflowers"
        //给陨石设置物理体
        bflowers.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        //物理体允许检测碰撞
        bflowers.physicsBody?.usesPreciseCollisionDetection = true
        //场景加入陨石
        currentscene.addChild(bflowers)
        //同时添加到数组中
        currentscene.bflowersArr.append(bflowers)
    }
}

protocol Animal: Life {
    
}

class Hanimal: Animal {
    var adaptability: Double = 50
    var borntime: Double = 4
    var influence: Double = 1
    var speed: Double = 1
    
    func born(currentscene : GameScene) -> Void {
        let bflowers = SKShapeNode()
        bflowers.path = CGPath(roundedRect: CGRect(x:-2, y:-4, width:4, height:8),
                               cornerWidth: 2, cornerHeight: 4, transform: nil)
        bflowers.strokeColor = SKColor.white
        bflowers.fillColor = SKColor.brown
        //获取场景宽，高
        let w = currentscene.size.width
        let h = currentscene.size.height
        //随机出现在场景的xy位置
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: h)
        //设置陨石的位置
        bflowers.position = CGPoint(x:x,y:y)
        //设置陨石的name属性
        bflowers.name = "bflowers"
        //给陨石设置物理体
        bflowers.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        //物理体允许检测碰撞
        bflowers.physicsBody?.usesPreciseCollisionDetection = true
        //场景加入陨石
        currentscene.addChild(bflowers)
        //同时添加到数组中
        currentscene.bflowersArr.append(bflowers)
    }
}

class Canimal: Animal {
    var adaptability: Double = 50
    var borntime: Double = 3
    var influence: Double = 1
    var speed: Double = 3
    
    func born(currentscene : GameScene) -> Void {
        let bflowers = SKShapeNode()
        bflowers.path = CGPath(roundedRect: CGRect(x:-2, y:-4, width:4, height:8),
                               cornerWidth: 2, cornerHeight: 4, transform: nil)
        bflowers.strokeColor = SKColor.white
        bflowers.fillColor = SKColor.brown
        //获取场景宽，高
        let w = currentscene.size.width
        let h = currentscene.size.height
        //随机出现在场景的xy位置
        let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: w)
        let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: h)
        //设置陨石的位置
        bflowers.position = CGPoint(x:x,y:y)
        //设置陨石的name属性
        bflowers.name = "bflowers"
        //给陨石设置物理体
        bflowers.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        //物理体允许检测碰撞
        bflowers.physicsBody?.usesPreciseCollisionDetection = true
        //场景加入陨石
        currentscene.addChild(bflowers)
        //同时添加到数组中
        currentscene.bflowersArr.append(bflowers)
    }
}
