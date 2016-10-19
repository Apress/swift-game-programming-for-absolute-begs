import SpriteKit

class LevelState : SKNode {
    
    var quitButton = Button(imageNamed:"spr_button_quit")
    var retryButton = Button(imageNamed:"spr_button_retry")
    var hintButton = Button(imageNamed:"spr_button_hint")
    let hintVisibleAction = SKAction.sequence([SKAction.unhide(), SKAction.waitForDuration(1), SKAction.hide()])
    var helpFrame = SKSpriteNode(imageNamed:"spr_frame_help")
    var hint = SKSpriteNode()
    var levelFinishedOverlay = SKSpriteNode(imageNamed: "spr_level_finished")
    var animals = SKNode()
    var levelNr = 0
    var firstMoveMade = false
    
    var wonSound = Sound("snd_won")
    
    // initializers
    init(fileReader: FileReader, levelNr : Int) {
        super.init()
        
        self.levelNr = levelNr
        self.name = "level\(levelNr)"

        // background
        let background = SKSpriteNode(imageNamed: "spr_background_level")
        background.zPosition = Layer.Background
        self.addChild(background)
        
        quitButton.zPosition = Layer.Overlay
        quitButton.position = GameScreen.instance.topRight - quitButton.center - CGPoint(x: 10, y: 10)
        self.addChild(quitButton)
        
        retryButton.zPosition = Layer.Overlay
        retryButton.position = GameScreen.instance.topRight - retryButton.center - CGPoint(x: 20 + quitButton.size.width, y: 10)
        self.addChild(retryButton)
        retryButton.hidden = true
        
        hintButton.zPosition = Layer.Overlay
        hintButton.position = retryButton.position
        self.addChild(hintButton)

        
        let _ = fileReader.nextLine() // for now, we do not use the title
        let help = fileReader.nextLine()
        let nrPairs = Int(fileReader.nextLine())!
        let sizeArr = fileReader.nextLine().componentsSeparatedByString(" ")
        let width = Int(sizeArr[0])!, height = Int(sizeArr[1])!
        let hintArr = fileReader.nextLine().componentsSeparatedByString(" ")
        
        let tileDimension = 75
        let tileField = TileField(rows: height, columns: width, cellWidth: tileDimension, cellHeight: tileDimension)
        tileField.name = "tileField"
        self.addChild(tileField)
        
        var lines: [String] = []
        for _ in 0..<height {
            var newLine = fileReader.nextLine()
            while newLine.characters.count < width {
                newLine += " "
            }
            lines.append(newLine)
        }
        
        for i in 0..<height {
            let currLine = lines[height-1-i]
            var j = 0
            for c in currLine.characters {
                j += 1
                switch c {
                case ".":
                    let tileSprite = "spr_field_\((i + j) % 2)"
                    let tile = Tile(imageNamed: tileSprite, type: .Normal)
                    tile.zPosition = Layer.Scene
                    tileField.layout.add(tile)
                case " ":
                    let tile = Tile()
                    tile.zPosition = Layer.Scene
                    tileField.layout.add(tile)
                case "r", "b", "g", "o", "p", "y", "m", "x", "s", "@", "R", "B", "G", "O", "P", "Y", "M", "X":
                    let tileSprite = "spr_field_\((i + j) % 2)"
                    let tile = Tile(imageNamed: tileSprite, type: .Normal)
                    tile.zPosition = Layer.Scene
                    tileField.layout.add(tile)
                    let p = Animal(type: String(c))
                    p.position = tile.position
                    p.initialPosition = tile.position
                    p.zPosition = Layer.Scene1
                    animals.addChild(p)
                default:
                    let tile = Tile(imageNamed: "spr_wall", type: .Wall)
                    tile.zPosition = Layer.Scene
                    tileField.layout.add(tile)
                }
            }
        }
        self.addChild(animals)
        
        // animal selector
        let animalSelector = AnimalSelector(spacing: tileDimension)
        animalSelector.name = "animalSelector"
        animalSelector.zPosition = Layer.Scene2
        self.addChild(animalSelector)
        
        // hint arrow
        let hintx = Int(hintArr[0])!, hinty = Int(hintArr[1])!
        hint = SKSpriteNode(imageNamed: "spr_arrow_hint_\(hintArr[2])")
        hint.zPosition = Layer.Scene2
        hint.position = tileField.layout.toPosition(hintx, row: hinty)
        hint.hidden = true
        self.addChild(hint)

        
        // help
        helpFrame.position = CGPoint(x: 0, y: GameScreen.instance.bottom + helpFrame.center.y + 10)
        helpFrame.zPosition = Layer.Overlay
        self.addChild(helpFrame)
        
        let textLabel = SKLabelNode(fontNamed: "Autodestruct BB")
        textLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 1)
        textLabel.fontSize = 24
        textLabel.text = help
        textLabel.horizontalAlignmentMode = .Center
        textLabel.verticalAlignmentMode = .Center
        textLabel.zPosition = 1
        helpFrame.addChild(textLabel)
        
        // pair list
        let goalFrame = SKSpriteNode(imageNamed: "spr_frame_goal")
        goalFrame.zPosition = Layer.Overlay
        goalFrame.position = GameScreen.instance.topLeft + CGPoint(x: 10 + goalFrame.center.x, y: -40)
        self.addChild(goalFrame)
        let pairList = PairList(nrPairs: nrPairs)
        pairList.name = "pairList"
        pairList.zPosition = Layer.Overlay1
        pairList.position = GameScreen.instance.topLeft + CGPoint(x: 130, y: -40)
        self.addChild(pairList)
        
        // winning overlay
        levelFinishedOverlay.hidden = true
        levelFinishedOverlay.zPosition = Layer.Overlay2
        self.addChild(levelFinishedOverlay)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        if !levelFinishedOverlay.hidden {
            if !inputHelper.containsTap(levelFinishedOverlay.box) {
                return
            }
            self.reset()
            DefaultsManager.instance.setLevelStatus(self.levelNr, status: "solved")
            if GameStateManager.instance.has("level\(levelNr+1)") {
                if DefaultsManager.instance.getLevelStatus(self.levelNr+1) == "locked" {
                    DefaultsManager.instance.setLevelStatus(self.levelNr+1, status: "unsolved")
                }
                GameStateManager.instance.switchTo("level\(levelNr+1)")
                GameStateManager.instance.reset()
            } else {
                GameStateManager.instance.switchTo("level")
            }
        }
        super.handleInput(inputHelper)
        if quitButton.tapped {
            GameStateManager.instance.switchTo("level")
        }
        if hintButton.tapped {
            hint.runAction(hintVisibleAction)
        } else if retryButton.tapped {
            reset()
        }
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        let pairList = childNodeWithName("//pairList") as! PairList
        if levelFinishedOverlay.hidden && pairList.completed {
            levelFinishedOverlay.hidden = false
            wonSound.play()
        }
        if !firstMoveMade {
            self.hintButton.hidden = !DefaultsManager.instance.hints
            self.retryButton.hidden = DefaultsManager.instance.hints
        }
    }
    
    override func reset() {
        super.reset()
        firstMoveMade = false
        helpFrame.runAction(SKAction.sequence([SKAction.unhide(),SKAction.waitForDuration(5), SKAction.hide()]))        
    }
    
    func findAnimalAtPosition(col: Int, row: Int) -> Animal? {
        for obj in animals.children {
            let animal = obj as! Animal
            let (currcol, currrow) = animal.currentBlock
            if currcol == col && currrow == row && animal.velocity == CGPoint.zero {
                return animal
            }
        }
        return nil
    }
    
    func applyFirstMoveMade() {
        self.hintButton.hidden = true
        self.retryButton.hidden = false
        firstMoveMade = true
    }
}
