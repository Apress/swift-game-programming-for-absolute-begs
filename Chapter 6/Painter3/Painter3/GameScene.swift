import SpriteKit

class GameScene: SKScene {
    
    var gameSize = CGSize()
    var gameWorld = SKNode()
    
    var background = SKSpriteNode(imageNamed: "spr_background")
    var cannonBarrel = SKSpriteNode(imageNamed:"spr_cannon_barrel")
    var cannonRed = SKSpriteNode(imageNamed: "spr_cannon_red")
    var cannonGreen = SKSpriteNode(imageNamed: "spr_cannon_green")
    var cannonBlue = SKSpriteNode(imageNamed: "spr_cannon_blue")
    var cannon = SKNode()
    
    var ball = SKNode()
    var ballRed = SKSpriteNode(imageNamed: "spr_ball_red")
    var ballGreen = SKSpriteNode(imageNamed: "spr_ball_green")
    var ballBlue = SKSpriteNode(imageNamed: "spr_ball_blue")
    var ballVelocity = CGPoint.zero
    var readyToShoot = false
    
    var touchLocation = CGPoint(x: 0, y: 0)
    var nrTouches = 0
    var hasTapped: Bool = false
    
    var delta: NSTimeInterval = 1/60
    
    override init(size: CGSize) {
        super.init(size: size)
        gameSize = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        background.zPosition = 0
        gameWorld.addChild(background)
        
        initCannon()
        gameWorld.addChild(cannon)
        
        initBall()
        gameWorld.addChild(ball)
        
        addChild(gameWorld)
        
        delta = NSTimeInterval(view.frameInterval) / 60
    }
    
    override func update(currentTime: NSTimeInterval) {
        handleInputCannon()
        handleInputBall()
        updateBall()
        hasTapped = false
    }
    
    func initCannon() {
        cannonRed.zPosition = 1
        cannonGreen.zPosition = 1
        cannonBlue.zPosition = 1
        cannonBarrel.anchorPoint = CGPoint(x:0.233, y:0.5)
        cannon.position = CGPoint(x:-430, y:-280)
        cannon.zPosition = 1
        cannonGreen.hidden = true
        cannonBlue.hidden = true
        cannon.addChild(cannonRed)
        cannon.addChild(cannonGreen)
        cannon.addChild(cannonBlue)
        cannon.addChild(cannonBarrel)
    }
    
    func handleInputCannon() {
        if nrTouches < 0 {
            return
        }
        let localTouch: CGPoint = gameWorld.convertPoint(touchLocation, toNode: cannonRed)
        if !cannonRed.frame.contains(localTouch) {
            // rotate the cannon toward the player touch location
            let opposite = touchLocation.y - cannon.position.y
            let adjacent = touchLocation.x - cannon.position.x
            cannonBarrel.zRotation = atan2(opposite, adjacent)
        } else if hasTapped {
            // change the cannon color
            let tmp = cannonBlue.hidden
            cannonBlue.hidden = cannonGreen.hidden
            cannonGreen.hidden = cannonRed.hidden
            cannonRed.hidden = tmp
        }
    }
    
    func initBall() {
        ball.zPosition = 1
        ball.addChild(ballRed)
        ball.addChild(ballGreen)
        ball.addChild(ballBlue)
        ball.hidden = true
    }
    
    func handleInputBall() {
        let localTouch: CGPoint = gameWorld.convertPoint(touchLocation, toNode: cannonRed)
        if nrTouches > 0 && !cannonRed.frame.contains(localTouch) && ball.hidden {
            readyToShoot = true
        }
        if (nrTouches <= 0 && readyToShoot && ball.hidden) {
            // shoot the ball
            ball.hidden = false
            readyToShoot = false
            let velocityMultiplier = CGFloat(1.4)
            ballVelocity.x = (touchLocation.x - cannon.position.x) * velocityMultiplier
            ballVelocity.y = (touchLocation.y - cannon.position.y) * velocityMultiplier
        }
    }
    
    func updateBall() {
        if !ball.hidden {
            ballVelocity.x *= 0.99
            ballVelocity.y -= 15
            ball.position.x += ballVelocity.x * CGFloat(delta)
            ball.position.y += ballVelocity.y * CGFloat(delta)
        }
        else {
            // calculate the ball position
            let opposite = sin(cannonBarrel.zRotation) * cannonBarrel.size.width * 0.6
            let adjacent = cos(cannonBarrel.zRotation) * cannonBarrel.size.width * 0.6
            ball.position = CGPoint(x: cannon.position.x + adjacent, y: cannon.position.y + opposite)
            
            // set the ball color
            ballRed.hidden = cannonRed.hidden
            ballGreen.hidden = cannonGreen.hidden
            ballBlue.hidden = cannonBlue.hidden
        }
        if isOutsideWorld(ball.position) {
            ball.hidden = true
            readyToShoot = false
        }
    }
    
    func isOutsideWorld(pos: CGPoint) -> Bool {
        return pos.x < -gameSize.width/2 || pos.x > gameSize.width/2 || pos.y < -gameSize.height/2
    }

    
    // Touch input handling
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        touchLocation = touch.locationInNode(self)
        nrTouches += touches.count
        hasTapped = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        touchLocation = touch.locationInNode(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nrTouches -= touches.count
    }
}