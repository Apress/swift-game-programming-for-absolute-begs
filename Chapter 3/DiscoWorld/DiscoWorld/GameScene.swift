import SpriteKit

class GameScene: SKScene {
    
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    
    override func didMoveToView(view: SKView) {
        myLabel.text = "Disco!"
        myLabel.fontSize = 65
        addChild(myLabel)
    }
    
    override func update(currentTime: NSTimeInterval) {
        let time: Double = currentTime % 1
        backgroundColor = UIColor(red: CGFloat(time), green: 0, blue: 0, alpha: 1)
    }
}