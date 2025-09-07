import Foundation

func L(_ key: String) -> String {
    return LanguageManager.shared.localizedString(forKey: key)
}
