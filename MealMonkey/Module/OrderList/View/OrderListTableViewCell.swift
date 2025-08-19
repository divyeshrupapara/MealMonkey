import UIKit

/// UITableViewCell subclass for displaying a single order in the order list
class OrderListTableViewCell: UITableViewCell {
    
    /// Image view displaying the first food item in the order
    @IBOutlet weak var imgFirstFood: UIImageView!
    
    /// Label displaying the order number
    @IBOutlet weak var lblOrderNo: UILabel!
    
    /// Label displaying the names of products added in the order
    @IBOutlet weak var lblAddedProducts: UILabel!
    
    /// Label displaying the total price of the order
    @IBOutlet weak var lblTotal: UILabel!
    
    /// Called after the cell has been loaded from the nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply corner radius and styling to the first food image
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgFirstFood])
    }
    
    /// Called when the selection state of the cell changes
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /**
     Configures the cell with order details.
     
     - Parameters:
        - products: Array of ProductModel representing products in the order.
        - orderNumber: The order number to display.
     */
    func orderListConfigureCell(products: [ProductModel], orderNumber: Int) {
        
        // Set order number label
        lblOrderNo.text = "Order #\(orderNumber)"
        
        // Join product names with commas and set the added products label
        let productNames = products.map { $0.strProductName }.joined(separator: ", ")
        lblAddedProducts.text = productNames
        
        // Calculate total price and set the total label
        let totalPrice = products.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 0)) }
        lblTotal.text = "Total: ₹\(String(format: "%.2f", totalPrice))"
        
        // Display the first product image if available
        if let firstImage = products.first?.strProductImage {
            imgFirstFood.image = UIImage(named: firstImage)
        }
    }
}
