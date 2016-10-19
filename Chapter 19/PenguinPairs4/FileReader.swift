import SpriteKit

class FileReader {
    
    var fileData: [String] = []
    var it = -1
    
    var eof: Bool {
        get {
            return it >= fileData.count - 1
        }
    }
    
    init(filename: String) {
        let filePath = NSBundle.mainBundle().pathForResource(filename, ofType:"txt")
        let data = try! String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding)
        fileData = data.componentsSeparatedByString("\n")
    }
    
    func nextLine() -> String {
        if (it >= fileData.count - 1) {
            return ""
        } else {
            it += 1
            return fileData[it]
        }
    }
    
    func reset() {
        it = -1
    }
}