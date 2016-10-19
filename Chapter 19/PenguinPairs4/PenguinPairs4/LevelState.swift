import SpriteKit

class LevelState : SKNode {
    
    var quitButton = Button(imageNamed:"spr_button_quit")
    var retryButton = Button(imageNamed:"spr_button_retry")
    var hintButton = Button(imageNamed:"spr_button_hint")
    var animals = SKNode()
    var levelNr = 0
    
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
        quitButton.position = GameScreen.instance.topRight
        quitButton.position.x -= quitButton.center.x + 10
        quitButton.position.y -= quitButton.center.y + 10
        self.addChild(quitButton)
        
        retryButton.zPosition = Layer.Overlay
        retryButton.position.x = quitButton.position.x - quitButton.size.width - 10
        retryButton.position.y = quitButton.position.y
        self.addChild(retryButton)
        retryButton.hidden = true
        
        hintButton.zPosition = Layer.Overlay
        hintButton.position = retryButton.position
        self.addChild(hintButton)

        
        _ = fileReader.nextLine() // for now, we do not use the title
        let _ = fileReader.nextLine() // for now, we do not use help
        let _ = Int(fileReader.nextLine())! // for now, we do not use the nr of pairs
        let sizeArr = fileReader.nextLine().componentsSeparatedByString(" ")
        let width = Int(sizeArr[0])!, height = Int(sizeArr[1])!
        let _ = fileReader.nextLine().componentsSeparatedByString(" ") // for now, we do not use the hint
        
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        super.handleInput(inputHelper)
        if quitButton.tapped {
            GameStateManager.instance.switchTo("level")
        }
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        self.hintButton.hidden = !DefaultsManager.instance.hints
        self.retryButton.hidden = DefaultsManager.instance.hints
    }
    
    override func reset() {
        super.reset()
        self.hintButton.hidden = !DefaultsManager.instance.hints
        self.retryButton.hidden = DefaultsManager.instance.hints
    }
}
