import Foundation
import UIKit

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 2:
            let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
           
        case 3:
            let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        default:
            break
        }
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.configureCell(category: arrCategory[indexPath.row])
        return cell
    }
}
