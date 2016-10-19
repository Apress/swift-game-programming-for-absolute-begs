import SpriteKit

class Animal : SKSpriteNode {
    
    var boxed = false
    var initialPosition = CGPoint()
    var initialEmptyBox = false
    var type = "x"
    var velocity = CGPoint.zero
    
    init(type: String) {
        boxed = type.uppercaseString == type
        var spriteName = "spr_animal_\(type)"
        if boxed && type != "@" {
            spriteName = "spr_animal_boxed_\(type.lowercaseString)"
        }
        let texture = SKTexture(imageNamed: spriteName)
        super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
        self.type = type
        initialEmptyBox = type.lowercaseString == "@"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var currentBlock: (Int, Int) {
        get {
            if let tileField = childNodeWithName("//tileField") as? TileField {
                var edgepos = position
                if velocity.x > 0 {
                    edgepos.x += CGFloat(tileField.layout.cellWidth) / 2
                } else if velocity.x < 0 {
                    edgepos.x -= CGFloat(tileField.layout.cellWidth) / 2
                } else if velocity.y > 0 {
                    edgepos.y += CGFloat(tileField.layout.cellHeight) / 2
                } else if velocity.y < 0 {
                    edgepos.y -= CGFloat(tileField.layout.cellHeight) / 2
                }
                return tileField.layout.toGridLocation(edgepos)
            }
            return (-1, -1)
        }
    }
    
    override func handleInput(inputHelper: InputHelper) {
        if hidden || boxed || isShark || velocity != CGPoint.zero {
            return
        }
        if !inputHelper.containsTap(box) {
            return
        }
        if let animalSelector = childNodeWithName("//animalSelector") as? AnimalSelector {
            if !inputHelper.containsTap(animalSelector.box) || animalSelector.hidden {
                animalSelector.position = self.position
                animalSelector.hidden = false
                animalSelector.selectedAnimal = self
            }
        }
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        position += velocity * CGFloat(delta)
        if hidden || velocity == CGPoint.zero {
            return
        }
        let tileField = childNodeWithName("//tileField") as! TileField
        let (targetcol, targetrow) = currentBlock
        
        if tileField.getTileType(targetcol, row: targetrow) == .Background {
            self.hidden = true
            self.velocity = CGPoint.zero
        } else if tileField.getTileType(targetcol, row: targetrow) == .Wall {
            self.stopMoving()
        } else {
            let lvl = GameStateManager.instance.currentGameState as? LevelState
            if let a = lvl?.findAnimalAtPosition(targetcol, row: targetrow) {
                if a.hidden {
                    return
                }
                if a.isSeal {
                    stopMoving()
                } else if a.isEmptyBox {
                    self.hidden = true
                    a.changeTypeTo(self.type.uppercaseString)
                } else if type.lowercaseString == a.type.lowercaseString || self.isMulticolor || a.isMulticolor {
                    a.hidden = true
                    self.hidden = true
                    let pairList = childNodeWithName("//pairList") as! PairList
                    pairList.addPair(type)
                } else if a.isShark {
                    a.hidden = true
                    self.hidden = true
                    stopMoving()
                } else {
                    self.stopMoving()
                }
            }
        }
    }
    
    override func reset() {
        position = initialPosition
        velocity = CGPoint.zero
        hidden = false
        if initialEmptyBox {
            changeTypeTo("@")
        }
    }
    
    func changeTypeTo(type: String) {
        boxed = type.uppercaseString == type
        var spriteName = "spr_animal_\(type)"
        if boxed && type != "@" {
            spriteName = "spr_animal_boxed_\(type.lowercaseString)"
        }
        texture = SKTexture(imageNamed: spriteName)
        self.type = type
    }
    
    func stopMoving() {
        let tileField = childNodeWithName("//tileField") as! TileField
        velocity = CGPoint.normalize(velocity)
        let (currcol, currrow) = currentBlock
        position = tileField.layout.toPosition(currcol  - Int(velocity.x), row: currrow - Int(velocity.y))
        velocity = CGPoint.zero
    }
    
    var isSeal: Bool {
        get {
            return type == "s"
        }
    }
    
    var isMulticolor: Bool {
        get {
            return type == "m"
        }
    }
    
    var isEmptyBox: Bool {
        get {
            return type == "@" && boxed
        }
    }
    
    var isShark: Bool {
        get {
            return type == "x"
        }
    }
}