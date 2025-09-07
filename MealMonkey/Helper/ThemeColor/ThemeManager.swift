import UIKit

struct AppTheme {
    let AppBackgroundColor: UIColor
    let MainColor: UIColor
    let PlaceholderColor: UIColor
    let PrimaryFontColor: UIColor
    let SecondaryFontColor: UIColor
    let MoreCellBackgroundColor: UIColor
    let TextFieldBackgroundColor: UIColor
}

enum ThemeType: String {
    case `default`
    case Maroon
    case Olive
    case Indigo
    case Peach
    case Cyan
    
    var theme: AppTheme {
        switch self {
        case .default:
            return AppTheme(
                AppBackgroundColor: UIColor(hex: "#FFFFFF"),
                MainColor: UIColor(hex: "#FC6011"),
                PlaceholderColor: UIColor(hex: "#B6B7B7"),
                PrimaryFontColor: UIColor(hex: "#4A4B4D"),
                SecondaryFontColor: UIColor(hex: "#7C7D7E"),
                MoreCellBackgroundColor: UIColor(hex: "#F6F6F6"),
                TextFieldBackgroundColor: UIColor(hex: "#F2F2F2")
            )
            
        case .Maroon:
            return AppTheme(
                AppBackgroundColor: UIColor(hex: "#FFFDF7"),
                MainColor: UIColor(hex: "#800020"),
                PlaceholderColor: UIColor(hex: "#C9A9A6"),
                PrimaryFontColor: UIColor(hex: "#3A2D2D"),
                SecondaryFontColor: UIColor(hex: "#6E4F4F"),
                MoreCellBackgroundColor: UIColor(hex: "#FBEAEA"),
                TextFieldBackgroundColor: UIColor(hex: "#FCEEEF") // soft rose-tint
            )
            
        case .Olive:
            return AppTheme(
                AppBackgroundColor: UIColor(hex: "#FAF9F6"),
                MainColor: UIColor(hex: "#556B2F"),
                PlaceholderColor: UIColor(hex: "#BDB76B"),
                PrimaryFontColor: UIColor(hex: "#2F2E1E"),
                SecondaryFontColor: UIColor(hex: "#6B6A4F"),
                MoreCellBackgroundColor: UIColor(hex: "#F3F6EC"),
                TextFieldBackgroundColor: UIColor(hex: "#F3F7F0")
            )
            
        case .Indigo:
            return AppTheme(
                AppBackgroundColor: UIColor(hex: "#F0F7FF"),
                MainColor: UIColor(hex: "#3F51B5"),
                PlaceholderColor: UIColor(hex: "#9CA3AF"),
                PrimaryFontColor: UIColor(hex: "#1A1A2E"),
                SecondaryFontColor: UIColor(hex: "#475569"),
                MoreCellBackgroundColor: UIColor(hex: "#E9EFFF"),
                TextFieldBackgroundColor: UIColor(hex: "#EEF1FA")
            )
            
        case .Peach:
            return AppTheme(
                AppBackgroundColor: UIColor(hex: "#FFF1E6"),
                MainColor: UIColor(hex: "#6A0DAD"),
                PlaceholderColor: UIColor(hex: "#D8A7D1"),
                PrimaryFontColor: UIColor(hex: "#3B1C32"),
                SecondaryFontColor: UIColor(hex: "#815C6B"),
                MoreCellBackgroundColor: UIColor(hex: "#FFECE2"),
                TextFieldBackgroundColor: UIColor(hex: "#FFF2ED")
            )
            
        case .Cyan:
            return AppTheme(
                AppBackgroundColor: UIColor(hex: "#F5FEFF"),
                MainColor: UIColor(hex: "#00BCD4"),
                PlaceholderColor: UIColor(hex: "#7FD3DD"),
                PrimaryFontColor: UIColor(hex: "#1E1E1E"),
                SecondaryFontColor: UIColor(hex: "#4A5A5C"),
                MoreCellBackgroundColor: UIColor(hex: "#E6FAFB"),
                TextFieldBackgroundColor: UIColor(hex: "#EAFBFD")
            )
        }
    }
}

class ThemeManager {
    static let shared = ThemeManager()
    
    private let userDefaultsKey = "selectedTheme"
    
    private init() {}
    
    var currentThemeType: ThemeType {
        get {
            if let raw = UserDefaults.standard.string(forKey: userDefaultsKey),
               let saved = ThemeType(rawValue: raw) {
                return saved
            }
            return .default
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: userDefaultsKey)
            NotificationCenter.default.post(name: .themeChanged, object: nil)
        }
    }
    
    var currentTheme: AppTheme {
        return currentThemeType.theme
    }
}

extension Notification.Name {
    static let themeChanged = Notification.Name("ThemeChanged")
}

// Helper for HEX colors
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
