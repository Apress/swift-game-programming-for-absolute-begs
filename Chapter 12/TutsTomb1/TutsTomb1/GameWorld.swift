import SpriteKit

class GameWorld : SKNode {
    
    var size = CGSize()
    var treasure1 = Treasure(0)
    var treasure2 = Treasure(1)
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        treasure1.position = CGPoint(x: -200, y: -200)
        treasure2.position = CGPoint(x: 200, y: 200)
        self.addChild(treasure1)
        self.addChild(treasure2)
    }
    
    func handleInput(inputHelper: InputHelper) {
        treasure1.handleInput(inputHelper)
        treasure2.handleInput(inputHelper)
    }
    
    func updateDelta(delta: NSTimeInterval) {
        
    }
    
    func reset() {
        
    }
    
    func isOutsideWorld(pos: CGPoint) -> Bool {
        return pos.x < -size.width/2 || pos.x > size.width/2 || pos.y < -size.height/2
    }
}