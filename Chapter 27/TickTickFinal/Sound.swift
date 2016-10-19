import AVFoundation

class Sound {
    
    // properties
    private var audioPlayer: AVAudioPlayer?
    
    // initializers
    init(_ fileName: String) {
        let soundURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: soundURL!)
        } catch {
            print("Sound not loaded (out of memory): " + fileName)
        }
    }
    
    // properties
    var looping: Bool {
        get {
            return audioPlayer?.numberOfLoops < 0
        }
        set {
            if newValue {
                audioPlayer?.numberOfLoops = -1
            } else {
                audioPlayer?.numberOfLoops = 0
            }
        }
    }
    
    var volume: Float {
        get {
            if audioPlayer != nil {
                return audioPlayer!.volume
            } else {
                return 0
            }
        }
        set {
            audioPlayer?.volume = newValue
        }
    }
    
    // methods
    func play() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        audioPlayer?.play()
    }
}
