import SpriteKit

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

class Slider : SKNode {
    
    var back = SKSpriteNode(imageNamed: "spr_slider_bar")
    var front = SKSpriteNode(imageNamed: "spr_slider_button")
    let leftMargin = CGFloat(4), rightMargin = CGFloat(7)
    var dragging = false
    var draggingIndex: Int?
    
    override init() {
        super.init()
        self.addChild(back)
        self.addChild(front)
        front.position = CGPoint(x: leftMargin - back.size.width/2 + front.size.width/2, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var value: CGFloat {
        get {
            return (front.position.x - front.size.width/2 - (back.position.x - back.size.width/2) - leftMargin) /
                (back.size.width - front.size.width - leftMargin - rightMargin)
        }
        set {
            front.position.x = newValue * (back.size.width - front.size.width - leftMargin - rightMargin) + leftMargin - back.size.width/2 + front.size.width/2
        }
    }
    
    override func handleInput(inputHelper: InputHelper) {
        if !inputHelper.isTouching {
            dragging = false
            draggingIndex = nil
            return
        }
        if inputHelper.containsTouch(back.box) {
            draggingIndex = inputHelper.getIDInRect(back.box)
        }
        if inputHelper.containsTouch(back.box) || dragging {
            if let draggingUnwrap = draggingIndex {
                let touchPos = inputHelper.getTouch(draggingUnwrap)
                front.position = CGPoint(x: leftMargin - back.size.width/2 + front.size.width/2, y: 0)
                front.position.x = clamp(touchPos.x - back.worldPosition.x,
                    min: leftMargin - back.size.width/2 + front.size.width/2, max: back.size.width/2 - front.size.width/2 - rightMargin)
                dragging = true
            }
        }
    }
}