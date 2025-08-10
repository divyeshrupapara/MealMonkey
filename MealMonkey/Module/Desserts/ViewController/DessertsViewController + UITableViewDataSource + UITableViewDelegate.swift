import Foundation
import UIKit

extension DessertsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)

        switch indexPath.row{
        case 0:
            if let productvc = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController {
                self.navigationController?.pushViewController(
                    productvc,
                    animated: true
                )
            }
        default:
            break;
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
