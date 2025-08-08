import Foundation
import UIKit

extension DessertsViewController: UITableViewDelegate {
}

extension DessertsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDessert.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DessertsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell", for: indexPath) as! DessertsTableViewCell
        
        cell.dessertConfigureCell(dessert: arrDessert[indexPath.row])
        return cell
    }
}
