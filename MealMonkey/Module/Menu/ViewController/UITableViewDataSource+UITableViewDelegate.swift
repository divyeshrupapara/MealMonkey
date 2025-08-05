import Foundation
import UIKit

extension MenuViewController: UITableViewDelegate {
    
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
