import SpriteKit

class TitleMenuState : SKNode {
    var playButton = Button(imageNamed:"spr_button_play")
    var helpButton = Button(imageNamed:"spr_button_help")
    
    // initializers
    override init() {
        super.init()
        
        self.name = "title"
        
        let layout = GridLayout(rows: 3, columns: 1, cellWidth: Int(playButton.size.width), cellHeight: Int(playButton.size.height))
        layout.yPadding = 5
        let buttons = SKNode()
        buttons.position.y = -200
        self.addChild(buttons)
        layout.target = buttons

        playButton.zPosition = Layer.Scene
        helpButton.zPosition = Layer.Scene
        layout.add(helpButton)
        layout.add(playButton)
        
        let background = SKSpriteNode(imageNamed: "spr_background_title")
        background.zPosition = Layer.Background
        self.addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if helpButton.tapped {
            GameStateManager.instance.switchTo("help")
        } else if playButton.tapped {
            GameStateManager.instance.switchTo("level")
        }
    }
}
