import Foundation
import UIKit

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    
    /// Called when a table view row is selected
    /// - Parameters:
    ///   - tableView: The table view object informing the delegate about the new row selection
    ///   - indexPath: The index path of the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                VC.selectedProductType = .food
                self.navigationController?.pushViewController(VC, animated: true)
            }
           
        case 1:
            let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                VC.selectedProductType = .Beverages
                self.navigationController?.pushViewController(VC, animated: true)
            }
           
        case 2:
            let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                VC.selectedProductType = .Desserts
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    /// Returns the number of rows in the table view section
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - section: The index number of the section
    /// - Returns: Number of categories in `arrCategory`
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    /// Provides a cell object for each row at the specified index path
    /// - Parameters:
    ///   - tableView: The table view requesting the cell
    ///   - indexPath: The index path specifying the location of the cell
    /// - Returns: Configured `MenuTableViewCell` for the category
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.configureCell(category: arrCategory[indexPath.row])
        return cell
    }
}
