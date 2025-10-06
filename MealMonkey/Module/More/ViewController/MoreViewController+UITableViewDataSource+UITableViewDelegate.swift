import Foundation
import UIKit

// MARK: - UITableViewDelegate
extension MoreViewController: UITableViewDelegate {
    
    /// Called when a table view row is selected
    /// Pushes the corresponding view controller based on the selected menu item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = arrMore[indexPath.row]
        
        switch selectedItem.intTag {
        case 0:
            // Navigate to Payment screen
            let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.PaymentViewController) as? PaymentViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        
        case 1:
            // Navigate to Order List screen
            let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.OrderListViewController) as? OrderListViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        
        case 2:
            // Navigate to About Us screen for Notifications
            let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.AboutUsViewController) as? AboutUsViewController {
                VC.objPageType = .Notification
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        case 3:
            // Navigate to About Us screen for Inbox
            let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.AboutUsViewController) as? AboutUsViewController {
                VC.objPageType = .Inbox
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        case 4:
            // Navigate to About Us screen
            let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.AboutUsViewController) as? AboutUsViewController {
                VC.objPageType = .AboutUs
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        case 5:
            // Navigate to Wish List screen
            let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.WishListViewController) as? WishListViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        case 6:
            // Show language selection alert
            let alert = UIAlertController(title: L("select_language"),
                                          message: nil,
                                          preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "English", style: .default, handler: { _ in
                LanguageManager.shared.setLanguage("en")
                LanguageManager.shared.reloadApp()
            }))
            
            alert.addAction(UIAlertAction(title: "Français", style: .default, handler: { _ in
                LanguageManager.shared.setLanguage("fr")
                LanguageManager.shared.reloadApp()
            }))
            
            alert.addAction(UIAlertAction(title: "हिन्दी", style: .default, handler: { _ in
                LanguageManager.shared.setLanguage("hi")
                LanguageManager.shared.reloadApp()
            }))
            
            alert.addAction(UIAlertAction(title: L("cancel"), style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        case 7:
            let alert = UIAlertController(
                title: L("theme_select_title"),
                message: nil,
                preferredStyle: .actionSheet
            )
            
            alert.addAction(UIAlertAction(title: L("theme_default"), style: .default, handler: { _ in
                ThemeManager.shared.currentThemeType = .default
            }))
            alert.addAction(UIAlertAction(title: L("theme_maroon"), style: .default, handler: { _ in
                ThemeManager.shared.currentThemeType = .Maroon
            }))
            alert.addAction(UIAlertAction(title: L("theme_olive"), style: .default, handler: { _ in
                ThemeManager.shared.currentThemeType = .Olive
            }))
            alert.addAction(UIAlertAction(title: L("theme_indigo"), style: .default, handler: { _ in
                ThemeManager.shared.currentThemeType = .Indigo
            }))
            alert.addAction(UIAlertAction(title: L("theme_peach"), style: .default, handler: { _ in
                ThemeManager.shared.currentThemeType = .Peach
            }))
            alert.addAction(UIAlertAction(title: L("theme_cyan"), style: .default, handler: { _ in
                ThemeManager.shared.currentThemeType = .Cyan
            }))
            
            alert.addAction(UIAlertAction(title: L("common_cancel"), style: .cancel))
            present(alert, animated: true)
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension MoreViewController: UITableViewDataSource {
    
    /// Returns the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMore.count
    }
    
    /// Returns the configured cell for a given index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.MoreTableViewCell, for: indexPath) as! MoreTableViewCell
        cell.configureMenuCell(more: arrMore[indexPath.row])
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }
}

/// Enum representing different page types for the "More" section
enum PageType {
    case PayMent
    case MyOrders
    case Notification
    case Inbox
    case AboutUs
    case WishList
}
