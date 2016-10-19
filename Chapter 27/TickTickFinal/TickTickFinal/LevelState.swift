import SpriteKit

class LevelState : SKNode {
    
    var quitButton = Button(imageNamed: "spr_button_quit")
    var levelNr = 0
    var waterDrops = [WaterDrop]()
    
    var tileField = TileField()
    var world = SKNode()
    var levelFinishedOverlay = SKSpriteNode(imageNamed: "spr_welldone")
    var gameoverOverlay = SKSpriteNode(imageNamed: "spr_gameover")
    var helpFrame = SKSpriteNode(imageNamed:"spr_frame_hint")
    
    
    var completed : Bool {
        get {
            for w in waterDrops {
                if !w.hidden {
                    return false
                }
            }
            let player = childNodeWithName("//player")!
            let exit = childNodeWithName("//exit")!
            return exit.box.intersects(player.box)
        }
    }
    
    var gameOver : Bool {
        get {
            let player = childNodeWithName("//player") as! Player
            let timer = childNodeWithName("//timer") as! Timer
            return !player.alive || timer.timeLeft < 0
        }
    }
    
    // initializers
    init(fileReader: FileReader, levelNr : Int) {
        self.levelNr = levelNr
        super.init()
        self.name = "level\(levelNr)"
        self.addChild(world)
        
        
        quitButton.zPosition = Layer.Overlay
        quitButton.position = GameScreen.instance.topRight - quitButton.center - CGPoint(x: 10, y: 10)
        self.addChild(quitButton)
        
        let help = fileReader.nextLine()
        let sizeArr = fileReader.nextLine().componentsSeparatedByString(" ")
        let width = Int(sizeArr[0])!, height = Int(sizeArr[1])!
        let timeForLevel = Int(fileReader.nextLine())!
        
        tileField = TileField(rows: height, columns: width, cellWidth: 72, cellHeight: 55)
        tileField.name = "tileField"
        world.addChild(tileField)
        
        // background
        addBackground()
        
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
                tileField.layout.add(loadTile(c, x: j, y: i))
                j += 1
            }
        }
        
        // help
        helpFrame.position = CGPoint(x: 0, y: GameScreen.instance.top - helpFrame.center.y - 10)
        helpFrame.zPosition = Layer.Overlay
        self.addChild(helpFrame)
        
        let textLabel = SKLabelNode(fontNamed: "SmackAttackBB")
        textLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 1)
        textLabel.fontSize = 16
        textLabel.text = help
        textLabel.horizontalAlignmentMode = .Center
        textLabel.verticalAlignmentMode = .Center
        textLabel.zPosition = 1
        textLabel.position = CGPoint(x: 45, y: -5)
        helpFrame.addChild(textLabel)
        
        let walkLeftButton = Button(imageNamed:"spr_button_left")
        walkLeftButton.name = "button_walkleft"
        walkLeftButton.position = GameScreen.instance.bottomLeft + walkLeftButton.center + CGPoint(x: 10, y: 10)
        walkLeftButton.zPosition = Layer.Overlay1
        self.addChild(walkLeftButton)
        let walkRightButton = Button(imageNamed:"spr_button_right")
        walkRightButton.name = "button_walkright"
        walkRightButton.position = walkLeftButton.position
        walkRightButton.position.x += walkRightButton.size.width + 10
        walkRightButton.zPosition = Layer.Overlay1
        self.addChild(walkRightButton)
        let jumpButton = Button(imageNamed:"spr_button_jump")
        jumpButton.name = "button_jump"
        jumpButton.position = GameScreen.instance.bottomRight + jumpButton.center - CGPoint(x: jumpButton.size.width + 10, y: -10)
        jumpButton.zPosition = Layer.Overlay1
        self.addChild(jumpButton)
        
        // timer
        let timer = Timer(totalTime: Double(timeForLevel))
        timer.name = "timer"
        timer.position = GameScreen.instance.topLeft + CGPoint(x: 100, y: -70)
        self.addChild(timer)
        
        // winning overlay
        levelFinishedOverlay.hidden = true
        levelFinishedOverlay.zPosition = Layer.Overlay
        self.addChild(levelFinishedOverlay)
        
        gameoverOverlay.hidden = true
        gameoverOverlay.zPosition = Layer.Overlay
        self.addChild(gameoverOverlay)
        
        self.reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadTile(c: Character, x: Int, y: Int) -> SKNode {
        switch c {
            case "-":
                return loadBasicTile("spr_platform", tileType: TileType.Platform)
            case "+":
                return loadBasicTile("spr_platform_hot", tileType: TileType.Platform, hot: true)
            case "@":
                return loadBasicTile("spr_platform_ice", tileType: TileType.Platform, ice: true)
            case "#":
                return loadBasicTile("spr_wall", tileType: TileType.Wall)
            case "^":
                return loadBasicTile("spr_wall_hot", tileType: TileType.Wall, hot: true)
            case "*":
                return loadBasicTile("spr_wall_ice", tileType: TileType.Wall, ice: true)
            case "W":
                return loadWaterTile(x, y: y)
            case "X":
                return loadEndTile(x, y: y)
            case "1":
                return loadStartTile(x, y: y)
            case "R":
                return loadRocketTile(x, y: y, moveToLeft: true)
            case "r":
                return loadRocketTile(x, y: y, moveToLeft: false)
            case "A", "B", "C":
                return loadFlameTile(c, x: x, y: y)
            case "S":
                return loadSparkyTile(x, y: y)
            case "T":
                return loadTurtleTile(x, y: y)
            default:
                return Tile()
        }
    }
    
    func addBackground() {
        
        let backgrounds = SKNode()
        world.addChild(backgrounds)
        
        // sky
        let background = SKSpriteNode(imageNamed: "spr_sky")
        background.xScale = CGFloat(tileField.layout.width) / background.size.width
        background.yScale = CGFloat(tileField.layout.height) / background.size.height
        background.zPosition = Layer.Background
        backgrounds.addChild(background)
        
        // mountains
        let nrItems: Int = Int(tileField.layout.width) / 150
        for _ in 1...nrItems {
            let mountainSpriteName = "spr_mountain_\(arc4random_uniform(2))"
            let mountain = SKSpriteNode(imageNamed: mountainSpriteName)
            mountain.zPosition = Layer.Background1
            mountain.position = CGPoint(x: randomCGFloat() * (tileField.layout.width + mountain.size.width) - tileField.layout.width / 2,
                y: -CGFloat(tileField.layout.height)/2 + mountain.size.height/2)
            backgrounds.addChild(mountain)
        }
        
        // clouds
        for _ in 1...nrItems {
            let cloud = Cloud()
            cloud.zPosition = Layer.Background2
            backgrounds.addChild(cloud)
        }
    }

    func loadBasicTile(imageNamed : String, tileType: TileType, hot: Bool = false, ice: Bool = false) -> SKNode {
        let t = Tile(imageNamed: imageNamed, type: tileType)
        t.hot = hot
        t.ice = ice
        t.zPosition = Layer.Scene
        return t
    }
    
    func loadWaterTile(x: Int, y: Int) -> SKNode {
        let w = WaterDrop()
        w.position = tileField.layout.toPosition(x, row: y)
        w.position.y += 10
        w.zPosition = Layer.Scene1
        world.addChild(w)
        self.waterDrops.append(w)
        return Tile()
    }

    func loadStartTile(x: Int, y: Int) -> SKNode {
        var startPosition = tileField.layout.toPosition(x, row: y)
        startPosition.y -= CGFloat(tileField.layout.cellHeight / 2)
        let player = Player(startPos: startPosition)
        player.name = "player"
        player.zPosition = Layer.Scene1
        world.addChild(player)
        return Tile()
    }
    
    func loadEndTile(x: Int, y: Int) -> SKNode {
        let exit = SKSpriteNode(imageNamed: "spr_goal")
        exit.name = "exit"
        exit.anchorPoint = CGPoint(x: 0.5, y: 0)
        exit.position = tileField.layout.toPosition(x, row: y)
        exit.position.y -= CGFloat(tileField.layout.cellHeight / 2)
        exit.zPosition = Layer.Scene1
        world.addChild(exit)
        return Tile()
    }
    
    func loadRocketTile(x: Int, y: Int, moveToLeft: Bool) -> SKNode {
        var startPosition = tileField.layout.toPosition(x, row: y)
        startPosition.y += 10
        let enemy = Rocket(moveToLeft: moveToLeft, startPos: startPosition)
        enemy.zPosition = Layer.Scene1
        world.addChild(enemy)
        return Tile()
    }
    
    func loadTurtleTile(x: Int, y: Int) -> SKNode {
        let turtle = Turtle()
        turtle.position = tileField.layout.toPosition(x, row: y)
        turtle.position.y += 20
        turtle.zPosition = Layer.Scene1
        world.addChild(turtle)
        return Tile()
    }
    
    func loadSparkyTile(x: Int, y: Int) -> SKNode {
        var pos = tileField.layout.toPosition(x, row: y)
        pos.y += 100
        let sparky = Sparky(position: pos)
        sparky.zPosition = Layer.Scene1
        world.addChild(sparky)
        return Tile()
    }
    
    func loadFlameTile(c: Character, x: Int, y: Int) -> SKNode {
        var startPosition = tileField.layout.toPosition(x, row: y)
        startPosition.y += 10
        var flame: AnimatedNode
        if c == "A" {
            flame = PatrollingEnemy()
        } else if c == "B" {
            flame = PlayerFollowingEnemy()
        } else {
            flame = UnpredictableEnemy()
        }
        flame.position = tileField.layout.toPosition(x, row: y)
        flame.position.y -= CGFloat(tileField.layout.cellHeight / 2)
        flame.zPosition = Layer.Scene1
        world.addChild(flame)
        return Tile()
    }
    
    override func handleInput(inputHelper: InputHelper) {
        if !levelFinishedOverlay.hidden {
            if inputHelper.containsTap(levelFinishedOverlay.box) {
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
            return
        } else if !gameoverOverlay.hidden {
            if inputHelper.containsTap(gameoverOverlay.box) {
                self.reset()
            }
            return
        }
        super.handleInput(inputHelper)
        if quitButton.tapped {
            self.reset()
            GameStateManager.instance.switchTo("level")
        }
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        
        // find the player
        let player = childNodeWithName("//player") as! Player
        
        // let the camera follow the player
        let minx = CGFloat(-tileField.layout.width/2) + GameScreen.instance.size.width/2
        let maxx = CGFloat(tileField.layout.width/2) - GameScreen.instance.size.width/2
        let miny = CGFloat(-tileField.layout.height/2) + GameScreen.instance.size.height/2
        let maxy = CGFloat(tileField.layout.height/2) - GameScreen.instance.size.height/2
        world.position.x = clamp(-player.position.x, min: minx, max: maxx)
        world.position.y = clamp(-player.position.y, min: miny, max: maxy)
        
        // check if we died
        gameoverOverlay.hidden = !self.gameOver
        
        // check if we run out of time
        let timer = childNodeWithName("//timer") as! Timer
        if timer.timeLeft < 0 {
            player.explode()
        }
        
        // level finished?
        if self.completed && levelFinishedOverlay.hidden {
            levelFinishedOverlay.hidden = false
            player.levelFinished()
            timer.running = false
        }
    }
    
    override func reset() {
        super.reset()
        levelFinishedOverlay.hidden = true
        helpFrame.runAction(SKAction.sequence([SKAction.unhide(),SKAction.waitForDuration(5), SKAction.hide()]))
    }
}