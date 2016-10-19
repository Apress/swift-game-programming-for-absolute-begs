import SpriteKit

class Treasure: SKNode {
    
    // properties
    var sprite = SKSpriteNode()
    var touchid: Int?
    
    var box: CGRect {
        get {
            return self.calculateAccumulatedFrame()
        }
    }
    
    // initializers
    init(_ type: Int) {
        super.init()
        sprite = SKSpriteNode(imageNamed: "spr_treasure_\(type)")
        self.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleInput(inputHelper: InputHelper) {
        if inputHelper.containsTap(self.box) {
            touchid = inputHelper.getIDInRect(self.box)
        }
        if let touchUnwrap = touchid {
            if inputHelper.isTouching(touchUnwrap) {
                self.position = inputHelper.getTouch(touchUnwrap)
            } else {
                touchid = nil
            }
        }
    }
}
