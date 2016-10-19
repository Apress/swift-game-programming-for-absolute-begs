import SpriteKit

class Player : AnimatedNode {
    
    var startPosition : CGPoint = CGPoint.zero
    var previousYPosition : CGFloat = 0

    var onTheGround = false
    var velocity = CGPoint.zero
    
    override var box: CGRect {
        get {
            var boundingBox = super.box
            let bbSize = boundingBox.size
            let xmultiplier: CGFloat = 0.75
            let ymultiplier: CGFloat = 0.8
            boundingBox.size = CGSize(width: bbSize.width * xmultiplier, height: bbSize.height * ymultiplier)
            boundingBox.origin.x += bbSize.width * (1 - xmultiplier) / 2
            return boundingBox
        }
    }
    
    init(startPos: CGPoint) {
        startPosition = startPos
        super.init()
        loadAnimation("spr_player_idle", name: "idle")
        loadAnimation("spr_player_run", looping: true, name: "run")
        loadAnimation("spr_player_jump", name: "jump")
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reset() {
        playAnimation("idle")
        self.position = startPosition
        previousYPosition = self.position.y
        self.velocity = CGPoint.zero
        onTheGround = true
        xScale = 1
    }
    
    override func handleInput(inputHelper: InputHelper) {
        if self.onTheGround {
            self.velocity.x = 0
        }
    
        // get the buttons
        let walkLeftButton = childNodeWithName("//button_walkleft") as! Button
        let walkRightButton = childNodeWithName("//button_walkright") as! Button
        let jumpButton = childNodeWithName("//button_jump") as! Button
        
        let walkingSpeed = CGFloat(300)
        if walkLeftButton.down {
            self.velocity.x = -walkingSpeed
        } else if walkRightButton.down {
            self.velocity.x = walkingSpeed
        }
        if self.velocity.x < 0 {
            self.xScale = -1
        } else if self.velocity.x > 0 {
            self.xScale = 1
        }
        
        if jumpButton.tapped && self.onTheGround {
            self.jump()
        }
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        position += velocity * CGFloat(delta)
        self.doPhysics(delta)
    
        if self.onTheGround {
            if self.velocity.x == 0 {
                self.playAnimation("idle")
            } else {
                self.playAnimation("run")
            }
        } else if self.velocity.y > 0 {
            self.playAnimation("jump")
        }
    }
    
    func jump(speed: CGFloat = 680) {
        self.velocity.y = speed
    }

    func doPhysics(delta: NSTimeInterval) {
        self.velocity.y -= CGFloat(1300 * delta)
        self.handleCollisions()
    }
    
    func handleCollisions() {
        self.onTheGround = false
        
        let tiles = childNodeWithName("//tileField") as! TileField
        let (x_floor, y_floor) = tiles.layout.toGridLocation(self.position)
        
        /* The original C-style for statement is deprecated. You can achieve the same thing
           by using a range, as illustrated below */
        for y in y_floor - 1...y_floor + 2 {
            for x in x_floor - 1...x_floor + 1 {
                
                let tileType = tiles.getTileType(x, row: y)
                if tileType == .Background {
                    continue
                }

                let tileBounds = tiles.getTileBox(x, row: y)

                var bbox = box
                bbox.origin.y -= 1
                if !tileBounds.intersects(bbox) {
                    continue
                }
                let depth = box.calculateIntersectionDepth(tileBounds)
                if fabs(depth.x) < fabs(depth.y) {
                    if tileType == .Wall {
                        self.position.x += depth.x
                    }
                    continue
                }
                let ydifference = self.position.y - self.previousYPosition
                if box.minY - ydifference >= tileBounds.maxY && tileType != .Background {
                    self.onTheGround = true
                    self.velocity.y = 0
                    self.position.y += depth.y
                } else if tileType == .Wall {
                    self.position.y += depth.y
                }
            }
        }
        self.previousYPosition = self.position.y
    }
}