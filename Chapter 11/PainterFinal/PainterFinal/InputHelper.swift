import SpriteKit

class InputHelper {
    var touchLocation = CGPoint(x: 0, y: 0)
    var nrTouches = 0
    var hasTapped: Bool = false
    
    var isTouching: Bool {
        get { return nrTouches > 0 }
    }
}