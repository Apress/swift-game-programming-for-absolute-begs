import SpriteKit

class GameScreen {
    var size = CGSize()
    
    static var instance = GameScreen()
    
    var topLeft: CGPoint {
        get {
            return CGPoint(x: -size.width/2, y: size.height/2)
        }
    }
    
    var topRight: CGPoint {
        get {
            return CGPoint(x: size.width/2, y: size.height/2)
        }
    }
    
    var bottomLeft: CGPoint {
        get {
            return CGPoint(x: -size.width/2, y: -size.height/2)
        }
    }
    
    var bottomRight: CGPoint {
        get {
            return CGPoint(x: size.width/2, y: -size.height/2)
        }
    }
    
    var top: CGFloat {
        get {
            return size.height/2
        }
    }
    
    var bottom: CGFloat {
        get {
            return -size.height/2
        }
    }
    
    var left: CGFloat {
        get {
            return -size.width/2
        }
    }
    
    var right: CGFloat {
        get {
            return size.width/2
        }
    }
}
