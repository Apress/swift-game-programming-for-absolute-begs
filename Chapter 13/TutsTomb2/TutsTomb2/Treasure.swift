import SpriteKit

class Treasure: GameObjectNode {
    
    var sprite = SKSpriteNode()
    var touchid: Int?
    var type = arc4random_uniform(5)
    
    override init() {
        super.init()
        sprite = SKSpriteNode(imageNamed: "spr_treasure_\(self.type)")
        sprite.zPosition = 1
        self.addChild(sprite)
        self.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        self.physicsBody?.contactTestBitMask = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if inputHelper.containsTap(self.box) {
            touchid = inputHelper.getIDInRect(self.box)
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
