import SpriteKit

class LevelMenuState : SKNode {
    var backButton = Button(imageNamed:"spr_button_back")
    var levelButtons = SKNode()
    var layout: GridLayout?
    var nrLevels = 0
    
    // initializers
    init(nrLevels: Int) {
        super.init()
        self.nrLevels = nrLevels
        self.name = "level"
        
        let nrCols = 4
        var nrRows = nrLevels / nrCols
        if nrLevels % nrCols != 0 {
            nrRows += 1
        }
        layout = GridLayout(rows: nrRows, columns: nrCols, cellWidth: 135, cellHeight: 135)
        layout?.xPadding = 10
        layout?.yPadding = 10
        self.addChild(levelButtons)
        layout?.target = levelButtons
        
        /* The original C-style for statement is deprecated. You can achieve the same thing
           by using a range and reversing it, as illustrated below */
        for i in (0..<nrRows).reverse() {
            for j in 0..<nrCols {
                if i*nrCols + j + 1 <= nrLevels {
                    let level = LevelButton(levelIndex: i*nrCols + j + 1)
                    level.name = "levelButton\(i*nrCols + j + 1)"
                    level.zPosition = Layer.Scene
                    layout?.add(level)
                } else {
                    layout?.add(SKNode())
                }
            }
        }
        
        let background = SKSpriteNode(imageNamed: "spr_background_levelselect")
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

