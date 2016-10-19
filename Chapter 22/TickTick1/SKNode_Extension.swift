import SpriteKit

extension SKNode {
    var box: CGRect {
        get {
            var boundingBox = self.calculateAccumulatedFrame()
            if parent != nil {
                boundingBox.origin = scene!.convertPoint(boundingBox.origin, fromNode: parent!)
            }
            return boundingBox
        }
    }
    
    var worldPosition: CGPoint {
        get {
            if parent != nil {
                return parent!.convertPoint(position, toNode: scene!)
            } else {
                return position
            }
        }
    }
    
    func handleInput(inputHelper: InputHelper) {
        for obj in children {
            obj.handleInput(inputHelper)
        }
    }
    
    func updateDelta(delta: NSTimeInterval) {
        for obj in children {
            obj.updateDelta(delta)
        }
    }
    
    func reset() {
        for obj in children {
            obj.reset()
        }
    }
}