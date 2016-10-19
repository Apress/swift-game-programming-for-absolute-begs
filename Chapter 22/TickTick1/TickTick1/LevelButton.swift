import SpriteKit

class LevelButton : Button {
    
    private var levelIndex = 0
    var locked = SKTexture(imageNamed: "spr_level_locked")
    var unsolved = SKTexture(imageNamed: "spr_level_unsolved")
    var solved = SKTexture(imageNamed: "spr_level_solved")
    
    init(levelIndex: Int) {
        self.levelIndex = levelIndex
        super.init(imageNamed: "spr_level_locked")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if self.texture == locked {
            return
        }
        if tapped {
            GameStateManager.instance.switchTo("level\(levelIndex)")
            GameStateManager.instance.reset()
        }
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        let status = "unsolved" //DefaultsManager.instance.getLevelStatus(self.levelIndex)
        if status == "locked" {
            self.texture = locked
        } else if status == "unsolved" {
            self.texture = unsolved
        } else {
            self.texture = solved
        }
    }
}