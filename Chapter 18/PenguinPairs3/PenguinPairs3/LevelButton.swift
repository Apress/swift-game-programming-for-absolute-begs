import SpriteKit

class LevelButton : Button {
    
    private var levelIndex = 0
    var locked = SKTexture(imageNamed: "spr_level_locked")
    var unsolved = SKTexture(imageNamed: "spr_level_unsolved")
    var solved = SKTexture(imageNamed: "spr_level_solved")
    
    init(levelIndex: Int) {
        self.levelIndex = levelIndex
        super.init(imageNamed: "spr_level_unsolved")
        let textLabel = SKLabelNode(fontNamed: "Autodestruct BB")
        textLabel.position = CGPoint(x: 0, y: -40)
        textLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        textLabel.fontSize = 24
        textLabel.text = String(levelIndex)
        textLabel.horizontalAlignmentMode = .Center
        textLabel.zPosition = Layer.Overlay
        self.addChild(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if self.texture == locked {
            return
        }
        if tapped {
            GameStateManager.instance.switchTo("level\(levelIndex)")
            GameStateManager.instance.reset()
        }
    }*/
}