import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (inout left: CGPoint, right: CGPoint) {
    left.x += right.x
    left.y += right.y
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func -= (inout left: CGPoint, right: CGPoint) {
    left.x -= right.x
    left.y -= right.y
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func *= (inout left: CGPoint, right: CGPoint) {
    left.x *= right.x
    left.y *= right.y
}

func *= (inout left: CGPoint, right: CGFloat) {
    left.x *= right
    left.y *= right
}

func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

func * (left: CGFloat, right: CGPoint) -> CGPoint {
    return CGPoint(x: left * right.x, y: left * right.y)
}

func == (left: CGPoint, right: CGPoint) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}
func != (left: CGPoint, right: CGPoint) -> Bool {
    return !(left == right)
}

func randomCGFloat() -> CGFloat {
    return CGFloat(arc4random()) /  CGFloat(UInt32.max)
}

func clamp(number:CGFloat, min:CGFloat, max:CGFloat) -> CGFloat
{
    if number < min {
        return min
    }
    else if number > max {
        return max
    }
    return number
}

extension CGPoint {
    static func normalize(p : CGPoint) -> CGPoint {
        let len = p.length
        return CGPoint(x: p.x / len, y: p.y / len)
    }
    
    var length : CGFloat {
        get {
            return sqrt(self.x * self.x + self.y * self.y)
        }
    }
}