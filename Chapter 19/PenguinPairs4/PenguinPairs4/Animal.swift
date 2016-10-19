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
    
    override func reset() {
        position = initialPosition
        velocity = CGPoint.zero
        hidden = false
        if initialEmptyBox {
            changeSpriteTo("@")
        }
    }
    
    func changeSpriteTo(type: String) {
        boxed = type.uppercaseString == type
        var spriteName = "spr_animal_\(type)"
        if boxed && type != "@" {
            spriteName = "spr_animal_boxed_\(type.lowercaseString)"
        }
        texture = SKTexture(imageNamed: spriteName)
        self.type = type
    }
    
    var isSeal: Bool {
        get {
            return type == "s" && !boxed
        }
    }
    
    var isMulticolor: Bool {
        get {
            return type == "m" && !boxed
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