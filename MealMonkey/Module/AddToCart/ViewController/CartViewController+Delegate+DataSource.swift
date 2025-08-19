import UIKit

/// UITableView delegate and data source implementation for CartViewController
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows (cart items) for the table view section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    /// Returns the cell configured for a given row at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        
        // Get product corresponding to current row
        let product = cartItems[indexPath.row]
        
        // Configure the cell for Cart
        cell.configCartCell(product: product)
        
        // Handle deletion of cart item
        cell.onDelete = { [weak self] in
            guard let self = self, let user = self.currentUser else { return }
            
            // Remove product from CoreData cart
            CoreDataManager.shared.removeFromCart(for: user, productId: product.intId)
            
            // Reload cart UI
            self.loadCart()
        }
        
        return cell
    }
}
