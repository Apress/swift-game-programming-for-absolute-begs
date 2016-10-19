import SpriteKit

class Button: GameObjectNode {
    
    // properties
    var sprite = SKSpriteNode()
    var tapped = false
    
    // initializers
    init(imageNamed: String) {
        super.init()
        sprite = SKSpriteNode(imageNamed: imageNamed)
        self.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        tapped = inputHelper.containsTap(self.box)
    }
}
