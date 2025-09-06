import UIKit

/// UITableViewDataSource methods for MyOrderViewController
extension MyOrderViewController: UITableViewDataSource {
    
    /// Returns the number of rows in the tableView based on the orders array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersProducts.count
    }
    
    /// Configures and returns each tableView cell with the corresponding order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue reusable cell
        let cell: MyOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.MyOrderTableViewCell, for: indexPath) as! MyOrderTableViewCell
        
        // Configure cell with the product order
        cell.myOrderConfigureCell(order: ordersProducts[indexPath.row])
        
        return cell
    }
}
