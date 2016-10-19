import SpriteKit

class PairList : SKNode {

    var colors: [String] = []
    
    init(nrPairs: Int) {
        super.init()
        
        // add the pair sprites
        for i in 0..<nrPairs {
            let pairSprite = SKSpriteNode(imageNamed: "spr_pairs_e")
            pairSprite.position = CGPoint(x: CGFloat(i) * (pairSprite.size.width + 5), y: 0)
            self.addChild(pairSprite)
            colors.append("e")
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var completed: Bool {
        get {
            for color in colors {
                if color == "e" {
                    return false
                }
            }
            return true
        }
    }
    
    func addPair(color : String) {
        for i in 0..<colors.count {
            if colors[i] == "e" {
                let sprite = children[i] as! SKSpriteNode
                sprite.texture = SKTexture(imageNamed: "spr_pairs_\(color)")
                colors[i] = color
                return
            }
        }
    }
    
    override func reset() {
        for i in 0..<colors.count {
            let sprite = children[i] as! SKSpriteNode
            sprite.texture = SKTexture(imageNamed: "spr_pairs_e")
            colors[i] = "e"
        }
    }
}
