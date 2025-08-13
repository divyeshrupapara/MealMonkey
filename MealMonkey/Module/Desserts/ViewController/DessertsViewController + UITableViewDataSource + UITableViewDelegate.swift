import Foundation
import UIKit

extension DessertsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredProducts[indexPath.row]
        
        productManager.addRecentProduct(selectedProduct.intId)
        
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController {
            detailVC.product = selectedProduct
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension DessertsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DessertsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell", for: indexPath) as! DessertsTableViewCell
        
        let product = filteredProducts[indexPath.row]
        cell.dessertConfigureCell(dessert: product)
        cell.layoutIfNeeded()
        return cell
    }
}

extension DessertsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let currentText = textField.text as NSString? {
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            let query = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if query.isEmpty {
                filteredProducts = allProducts
            } else {
                filteredProducts = allProducts.filter { $0.strProductName.localizedCaseInsensitiveContains(query) }
            }
            lblNoItem.isHidden = !filteredProducts.isEmpty
            tblDesserts.reloadData()
        }
        return true
    }
}
