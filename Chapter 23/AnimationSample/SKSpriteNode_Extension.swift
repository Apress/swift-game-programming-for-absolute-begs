import SpriteKit

extension SKSpriteNode {
    var center: CGPoint {
        get {
            return CGPoint(x: size.width / 2, y: size.height / 2)
        }
    }
}