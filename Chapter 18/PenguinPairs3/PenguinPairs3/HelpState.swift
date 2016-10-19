import SpriteKit

class HelpState : SKNode {
    var backButton = Button(imageNamed:"spr_button_back")
    
    // initializers
    override init() {
        super.init()
        
        self.name = "help"

        let background = SKSpriteNode(imageNamed: "spr_background_help")
        background.zPosition = Layer.Background
        self.addChild(background)
        backButton.zPosition = Layer.Scene
        backButton.position = CGPoint(x: 0, y: -320)
        self.addChild(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if backButton.tapped {
            GameStateManager.instance.switchTo("title")
        }
    }
}
