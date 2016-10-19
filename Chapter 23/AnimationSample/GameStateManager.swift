import SpriteKit

class GameStateManager : SKNode {
    
    static var instance = GameStateManager()
    
    var states : [SKNode] = []
    var plannedSwitch: String?
    
    static var world : SKNode {
        get { return GameStateManager.instance.currentGameState! }
    }
    
    private var currentGameState: SKNode? = nil
    
    func get(name: String) -> SKNode? {
        for state in states {
            if state.name == name {
                return state
            }
        }
        return nil
    }
    
    func switchTo(name: String) {
        plannedSwitch = name
    }
    
    func add(state: SKNode) {
        states.append(state)
    }
    
    func has(name: String) -> Bool {
        return get(name) != nil
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        if plannedSwitch == nil || !has(plannedSwitch!) {
            return
        }
        self.removeAllChildren()
        currentGameState = get(plannedSwitch!)
        self.addChild(currentGameState!)
    }
}