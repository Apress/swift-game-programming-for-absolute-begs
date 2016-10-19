import SpriteKit

class Animation : SKSpriteNode {
    
    var action = SKAction()
    
    init(atlasNamed: String, looping: Bool, frameTime: NSTimeInterval) {
        let atlas = SKTextureAtlas(named: atlasNamed)
        let numImages = atlas.textureNames.count
        var frames: [SKTexture] = []
        for i in 0..<numImages {
            let textureName = "\(atlasNamed)_\(i)"
            frames.append(atlas.textureNamed(textureName))
        }
        super.init(texture: frames[0], color: UIColor.whiteColor(), size: frames[0].size())
        
        let animateAction = SKAction.animateWithTextures(frames, timePerFrame: frameTime)
        if looping {
            action = SKAction.repeatActionForever(animateAction)
        } else {
            action = animateAction
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}