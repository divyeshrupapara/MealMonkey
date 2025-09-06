import UIKit

// MARK: - UITableViewDataSource
extension OrderListViewController: UITableViewDataSource {
    
    /// Returns the number of orders to display in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    /// Configures and returns a cell for a specific order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Dequeue reusable cell
        let cell: OrderListTableViewCell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.OrderListTableViewCell, for: indexPath) as! OrderListTableViewCell
        
        // Get the products for the current order
        let orderProducts = orders[indexPath.row]
        
        // Configure cell with products and order number
        cell.orderListConfigureCell(products: orderProducts, orderNumber: indexPath.row + 1)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension OrderListViewController: UITableViewDelegate {
    
    /// Handles selection of an order row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Load MyOrderViewController from storyboard
        let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.MyOrderViewController) as? MyOrderViewController {
            
            // Pass selected order's products to MyOrderViewController
            VC.ordersProducts = orders[indexPath.row]
            
            // Push the detail view controller
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
