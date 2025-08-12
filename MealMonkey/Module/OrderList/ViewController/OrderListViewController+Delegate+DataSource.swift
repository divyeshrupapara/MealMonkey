import UIKit

extension OrderListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: OrderListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        
        let orderProducts = orders[indexPath.row]
           cell.orderListConfigureCell(products: orderProducts, orderNumber: indexPath.row + 1)
        
        return cell
    }
}
