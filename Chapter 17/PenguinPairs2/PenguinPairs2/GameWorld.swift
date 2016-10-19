import SpriteKit

class GameWorld : SKNode {
    
    var size = CGSize()
    var musicSlider = Slider()
    var onOffButton = OnOffButton()
    var backgroundMusic = Sound("snd_music")
    
    // initializers
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let background = SKSpriteNode(imageNamed: "spr_background_options")
        background.zPosition = Layer.Background
        self.addChild(background)
        
        let onOffLabel = SKLabelNode(fontNamed: "Helvetica")
        onOffLabel.horizontalAlignmentMode = .Right
        onOffLabel.verticalAlignmentMode = .Center
        onOffLabel.position = CGPoint(x: -50, y: 50)
        onOffLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 1)
        onOffLabel.fontSize = 60
        onOffLabel.text = "Hints"
        self.addChild(onOffLabel)
        
        onOffButton.position = CGPoint(x: 200, y: 50)
        self.addChild(onOffButton)
        
        let musicLabel = SKLabelNode(fontNamed: "Helvetica")
        musicLabel.horizontalAlignmentMode = .Right
        musicLabel.verticalAlignmentMode = .Center
        musicLabel.position = CGPoint(x: -50, y: -100)
        musicLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 1)
        musicLabel.fontSize = 60
        musicLabel.text = "Music volume"
        self.addChild(musicLabel)
        
        
        musicSlider.position = CGPoint(x: 200, y: -100)
        self.addChild(musicSlider)
        
        backgroundMusic.looping = true
        backgroundMusic.volume = 0.5
        backgroundMusic.play()
        musicSlider.value = 0.5
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        backgroundMusic.volume = Float(musicSlider.value)
    }
}
