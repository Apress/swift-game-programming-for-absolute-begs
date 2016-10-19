import SpriteKit

struct TreasureType {
    static let Rock : UInt32 = 99
    static let Magic : UInt32 = 100
}

class Treasure: GameObjectNode {
    
    // properties
    var sprite = SKSpriteNode()
    var touchid: Int?
    var type: UInt32 = 0
    
    // initializers
    convenience init(range: UInt32) {
        let finalRange = min(range, 20)
        let tp = arc4random_uniform(finalRange)
        self.init(type: tp)
    }
    
    init(type: UInt32) {
        super.init()
        self.type = type

        if type == TreasureType.Rock {
            sprite = SKSpriteNode(imageNamed: "spr_rock")
        } else if arc4random_uniform(6) == 0 {
            sprite = SKSpriteNode(imageNamed: "spr_magic")
            self.type = TreasureType.Magic
        } else {
            sprite = SKSpriteNode(imageNamed: "spr_treasure_\(self.type)")
            self.runAction(SKAction.waitForDuration(20), completion: {
                let rock = Treasure(type: TreasureType.Rock)
                rock.position = self.position
                self.parent?.addChild(rock)
                self.removeFromParent()
            })
        }
        sprite.zPosition = 1
        self.position.y = 500
        self.addChild(sprite)
        self.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        self.physicsBody?.contactTestBitMask = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if inputHelper.containsTap(self.box) {
            touchid = inputHelper.getIDInRect(self.box)
        }
        if position.y >= 200 {
            touchid = nil
            if physicsBody?.velocity.dy >= 0 {
                physicsBody?.velocity = CGVector.zero
            }
            return
        }
        if let touchUnwrap = touchid {
            if inputHelper.isTouching(touchUnwrap) {
                var moveVector = inputHelper.getTouch(touchUnwrap)
                moveVector.x -= position.x
                moveVector.y -= position.y
                physicsBody?.velocity = CGVector(dx: moveVector.x * 10, dy: moveVector.y * 10)
            } else {
                touchid = nil
            }
        }
    }
}