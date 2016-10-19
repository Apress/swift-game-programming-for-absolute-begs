import SpriteKit

class MainState : SKNode {
    
    // initializers
    override init() {
        super.init()
        self.name = "main"
        
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
        
        let player = Player()
        player.position = GameScreen.instance.bottomLeft
        player.position.x += 300
        player.zPosition = Layer.Scene1
        self.addChild(player)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}