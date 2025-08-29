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
            /// Navigate to DessertsViewController for food category
            let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                VC.selectedProductType = .food
                self.navigationController?.pushViewController(VC, animated: true)
            }
           
        case 1:
            /// Navigate to DessertsViewController for beverages category
            let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                VC.selectedProductType = .Beverages
                self.navigationController?.pushViewController(VC, animated: true)
            }
           
        case 2:
            /// Navigate to DessertsViewController for desserts category
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
        return arrFilterCategory.count
    }
    
    /// Provides a cell object for each row at the specified index path
    /// - Parameters:
    ///   - tableView: The table view requesting the cell
    ///   - indexPath: The index path specifying the location of the cell
    /// - Returns: Configured `MenuTableViewCell` for the category
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        /// Set transparent background for cell
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        /// Configure cell with category data
        cell.configureCell(category: arrFilterCategory[indexPath.row])
        return cell
    }
}

extension MenuViewController: UITextFieldDelegate {
    
    /// Handles character changes in the search text field
    /// - Parameters:
    ///   - textField: The active text field
    ///   - range: The range of characters to be replaced
    ///   - string: The replacement string
    /// - Returns: Boolean indicating whether the text should change
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let currentText = textField.text as NSString? {
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            let query = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            /// Update filtered products based on search query
            if query.isEmpty {
                arrFilterCategory = arrCategory
            } else {
                arrFilterCategory = arrCategory.filter { $0.strCategoryName.localizedCaseInsensitiveContains(query) }
            }
            
            /// Show/hide "No Item" label
            lblNoItem.isHidden = !arrFilterCategory.isEmpty
            
            /// Reload table view with filtered results
            tblCategory.reloadData()
        }
        
        return true
    }
}
