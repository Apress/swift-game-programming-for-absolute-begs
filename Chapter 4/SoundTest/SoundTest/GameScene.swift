import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        let soundURL = NSBundle.mainBundle().URLForResource("snd_music", withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOfURL: soundURL!)
        audioPlayer.play()
        audioPlayer.volume = 0.4
    }
}