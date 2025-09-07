import UIKit

/// UITableViewCell subclass to display individual orders in the "My Orders" screen
class MyOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBack: UIView!
    /// Label to show the food name and quantity
    @IBOutlet weak var lblFoodNameXQty: UILabel!
    
    /// Label to show the total price of the item
    @IBOutlet weak var lblFoodPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: .themeChanged,
            object: nil
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// Configures the cell with the given order details
    /// - Parameter order: ProductModel containing order information
    func myOrderConfigureCell(order: ProductModel) {
        // Display food name along with quantity
        lblFoodNameXQty.text = order.strProductName + " x " + "\(order.intProductQty!)"
        
        // Calculate total price based on quantity and display it
        lblFoodPrice.text = "$ \(String(format: "%.2f", order.doubleProductPrice * Double(order.intProductQty ?? 0)))"
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        viewBack.backgroundColor = theme.MoreCellBackgroundColor
        lblFoodNameXQty.textColor = theme.PrimaryFontColor
        lblFoodPrice.textColor = theme.PrimaryFontColor
    }
}
