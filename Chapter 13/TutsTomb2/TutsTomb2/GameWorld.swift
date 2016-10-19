import SpriteKit

class GameWorld : GameObjectNode, SKPhysicsContactDelegate {
    
    var size = CGSize()
    var treasures = GameObjectNode()
    
    func setup() {
        let background = SKSpriteNode(imageNamed:"spr_background")
        background.zPosition = 0
        addChild(background)
        
        self.addChild(treasures)
        
        // add a few treasures
        for i in 0...4 {
            let treasure = Treasure()
            treasure.position = CGPoint(x: -250 + i * 120, y: 200)
            treasures.addChild(treasure)
        }
        
        // add the surrounding walls
        let floor = SKNode()
        floor.position.y = -400
        var square = CGSize(width: GameScene.world.size.width, height: 200)
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: square)
        floor.physicsBody?.dynamic = false
        addChild(floor)
        
        let ceiling = SKNode()
        ceiling.position.y = 800
        square = CGSize(width: GameScene.world.size.width, height: 200)
        ceiling.physicsBody = SKPhysicsBody(rectangleOfSize: square)
        ceiling.physicsBody?.dynamic = false
        addChild(ceiling)
        
        let leftSideWall = SKNode()
        leftSideWall.position.x = -340
        square = CGSize(width: 100, height: GameScene.world.size.height)
        leftSideWall.physicsBody = SKPhysicsBody(rectangleOfSize: square)
        leftSideWall.physicsBody?.dynamic = false
        addChild(leftSideWall)
        
        let rightSideWall = SKNode()
        rightSideWall.position.x = 340
        square = CGSize(width: 100, height: size.height)
        rightSideWall.physicsBody = SKPhysicsBody(rectangleOfSize: square)
        rightSideWall.physicsBody?.dynamic = false
        addChild(rightSideWall)
    }
    
    // physics handling
    func didBeginContact(contact: SKPhysicsContact) {
        //let firstBody = contact.bodyA.node as? Treasure
        //let secondBody = contact.bodyB.node as? Treasure
        print("Contact at position \(contact.contactPoint)")
    }
}
