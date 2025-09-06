import Foundation
import UIKit

// MARK: - UITableViewDelegate
extension DessertsViewController: UITableViewDelegate {
    
    /// Called when a table view row is selected
    /// Navigates to the product detail screen for the selected dessert
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredProducts[indexPath.row]
        
        // Add product to recent products
        productManager.addRecentProduct(selectedProduct.intId)
        
        // Instantiate FoodDetailViewController and pass the selected product
        let storyboard = UIStoryboard(name: Main.StoryBoard.MenuStoryboard, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.FoodDetailViewController) as? FoodDetailViewController {
            detailVC.product = selectedProduct
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension DessertsViewController: UITableViewDataSource {
    
    /// Returns the number of rows in the table view section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    /// Configures each table view cell with the corresponding dessert product
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DessertsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.DessertsTableViewCell, for: indexPath) as! DessertsTableViewCell
        
        let product = filteredProducts[indexPath.row]
        cell.dessertConfigureCell(dessert: product)
        cell.layoutIfNeeded()
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension DessertsViewController: UITextFieldDelegate {
    
    /// Called whenever text changes in the search text field
    /// Filters desserts based on user input and updates the table view
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let currentText = textField.text as NSString? {
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            let query = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Update filtered products based on search query
            if query.isEmpty {
                filteredProducts = allProducts
            } else {
                filteredProducts = allProducts.filter { $0.strProductName.localizedCaseInsensitiveContains(query) }
            }
            
            // Show/hide "No Item" label
            if filteredProducts.isEmpty {
                LottieAnimationHelper.showEmptyState(on: tblDesserts,
                                                         animationName: "Food Prepared - Food app",
                                                         message: "No Such Product")
            } else {
                LottieAnimationHelper.removeEmptyState(from: tblDesserts)
            }
            
            // Reload table view with filtered results
            tblDesserts.reloadData()
        }
        return true
    }
}
