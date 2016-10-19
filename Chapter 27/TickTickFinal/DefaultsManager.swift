import Foundation

class DefaultsManager {
    
    static let instance = DefaultsManager()
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    init() {
        if defaults.arrayForKey("levelStatus") != nil {
            /* the default settings were already created for this player,
               so we're done. */
            return
        }
        let filePath = NSBundle.mainBundle().pathForResource("defaults", ofType:"plist")
        let defaultPreferences: NSDictionary = NSDictionary(contentsOfFile: filePath!)!
        for (key, value) in defaultPreferences {
            defaults.setObject(value, forKey: key as! String)
        }
    }
    
    func reset() {
        let filePath = NSBundle.mainBundle().pathForResource("defaults", ofType:"plist")
        let defaultPreferences: NSDictionary = NSDictionary(contentsOfFile: filePath!)!
        for (key, _) in defaultPreferences {
            defaults.removeObjectForKey(key as! String)
        }
    }
    
    func getLevelStatus(levelNr: Int) -> String {
        let levels = defaults.stringArrayForKey("levelStatus")
        if levelNr < 1 || levelNr > levels?.count {
            return "locked"
        } else {
            return levels![levelNr - 1]
        }
    }
    
    func setLevelStatus(levelNr: Int, status: String) {
        var levels = defaults.stringArrayForKey("levelStatus")
        if levelNr < 1 || levelNr > levels?.count {
            return
        } else {
            levels![levelNr-1] = status
            defaults.setObject(levels, forKey: "levelStatus")
        }
    }
}
