import SpriteKit

class Button: SKSpriteNode {
    
    // properties
    var tapped = false
    var down = false
    
    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        tapped = inputHelper.containsTap(self.box) && !self.hidden
        down = inputHelper.containsTouch(self.box) && !self.hidden
    }
}