import SpriteKit

enum TileType {
    case Wall
    case Background
    case Platform
}

class Tile : SKSpriteNode {
    
    private var tileType: TileType = .Background
    var hot = false, ice = false
    
    convenience init() {
        self.init(imageNamed: "spr_wall", type: .Background)
    }
    
    init(imageNamed: String, type: TileType) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var type : TileType {
        get {
            return tileType
        }
        set {
            tileType = newValue
            self.hidden = tileType == .Background
        }
    }
}