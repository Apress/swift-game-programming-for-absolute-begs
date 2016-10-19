import SpriteKit

class AnimalSelector : SKNode {
    
    var arrowRight = Button(imageNamed: "spr_arrow_r")
    var arrowUp = Button(imageNamed: "spr_arrow_u")
    var arrowLeft = Button(imageNamed: "spr_arrow_l")
    var arrowDown = Button(imageNamed: "spr_arrow_d")
    var selectedAnimal : Animal? = nil
    
    init(spacing: Int) {
        super.init()
        arrowRight.position = CGPoint(x: spacing, y: 0)
        arrowUp.position = CGPoint(x: 0, y: spacing)
        arrowLeft.position = CGPoint(x: -spacing, y: 0)
        arrowDown.position = CGPoint(x: 0, y: -spacing)
        self.addChild(arrowRight)
        self.addChild(arrowUp)
        self.addChild(arrowLeft)
        self.addChild(arrowDown)
        self.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        if hidden {
            return
        }
        super.handleInput(inputHelper)
        var animalVelocity = CGPoint.zero
        if arrowRight.tapped {
            animalVelocity.x = 1
        } else if arrowLeft.tapped {
            animalVelocity.x = -1
        } else if arrowUp.tapped {
            animalVelocity.y = 1
        } else if arrowDown.tapped {
            animalVelocity.y = -1
        }
        animalVelocity *= 500
        selectedAnimal?.velocity = animalVelocity
        if inputHelper.hasTapped && !inputHelper.containsTap(selectedAnimal!.box) {
            self.hidden = true
            selectedAnimal = nil
        }
    }
}
