import SpriteKit

class GameWorld : GameObjectNode {
    
    var size = CGSize()
    var levelButtons = GameObjectNode()
    
    // initializers
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let nrCols = 6, nrLevels = 12
        var nrRows = nrLevels / nrCols
        if nrLevels % nrCols != 0 {
            nrRows += 1
        }
        let layout = GridLayout(rows: nrRows, columns: nrCols, cellWidth: 150, cellHeight: 150)
        layout.xPadding = 5
        layout.yPadding = 5
        layout.target = levelButtons
        
        /* The original C-style for statement is deprecated. You can achieve the same thing
           by using a range and reversing it, as illustrated below */
        for i in (0..<nrRows).reverse() {
            for j in 0..<nrCols {
                if i*nrCols + j < nrLevels {
                    let level = SKSpriteNode(imageNamed: "spr_level_unsolved")
                    level.zPosition = Layer.Scene
                    layout.add(level)
                } else {
                    layout.add(SKNode())
                }
            }
        }
        
        self.addChild(levelButtons)
        
        let background = SKSpriteNode(imageNamed: "spr_background_levelselect")
        background.zPosition = Layer.Background
        self.addChild(background)
    }
}
