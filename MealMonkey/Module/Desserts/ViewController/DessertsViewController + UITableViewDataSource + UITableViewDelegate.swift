import Foundation
import UIKit

extension DessertsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = arrProducts[indexPath.row]
        
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController {
            
            detailVC.product = selectedProduct
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension DessertsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducts.count // ✅ Use filtered array
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DessertsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell", for: indexPath) as! DessertsTableViewCell
        
        let product = arrProducts[indexPath.row] // ✅ Use filtered array
        cell.dessertConfigureCell(dessert: product)
        return cell
    }
}
