import Foundation
import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    private let userDefaultsKey = "selectedLanguage"
    
    var currentLanguage: String {
        return UserDefaults.standard.string(forKey: userDefaultsKey) ?? "en"
    }
    
    func setLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: userDefaultsKey)
        UserDefaults.standard.synchronize()
    }
    
    func localizedString(forKey key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return key // fallback
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    func reloadApp() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let rootVC = storyboard.instantiateInitialViewController() {
            window.rootViewController = rootVC
            window.makeKeyAndVisible()
        }
    }
}
