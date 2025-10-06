import UIKit

/// MainTabViewController manages the application's tab bar interface.
class MainTabViewController: UITabBarController {

    /// Called after the controller's view is loaded into memory.
    /// Use this method to perform additional setup if needed.
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: .themeChanged,
            object: nil
        )
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        tabBar.tintColor = theme.MainColor
        tabBar.unselectedItemTintColor = theme.SecondaryFontColor
        tabBar.barTintColor = theme.AppBackgroundColor
        tabBar.backgroundColor = theme.AppBackgroundColor
    }
}
