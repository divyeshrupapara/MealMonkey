import UIKit

/// Custom table view cell for displaying a dessert item
class DessertsTableViewCell: UITableViewCell {
    
    /// UIImageView to display the dessert image
    @IBOutlet weak var imgDessert: UIImageView!
    
    /// UILabel to display the dessert title
    @IBOutlet weak var lblDessertTitle: UILabel!
    
    /// UIButton representing a star (e.g., for favorites or rating)
    @IBOutlet weak var btnStar: UIButton!
    
    /// UILabel to display the dessert rating
    @IBOutlet weak var lblRating: UILabel!
    
    /// UILabel to display additional text (e.g., category or type)
    @IBOutlet weak var lblText: UILabel!
    
    /// Called after the view has been loaded from the nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Configure the selection behavior for the cell
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Configures the cell with dessert data
    /// - Parameter dessert: The `ProductModel` representing the dessert
    func dessertConfigureCell(dessert: ProductModel) {
        DispatchQueue.main.async {
            self.lblDessertTitle.text = dessert.strProductName
            self.lblText.attributedText = self.getStyledText(dessert.objProductType.rawValue)
            self.lblRating.text = "\(dessert.floatProductRating)"
            self.imgDessert.image = UIImage(named: dessert.strProductImage)
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    /// Returns an attributed string with a styled dot character
    /// - Parameter text: The input string containing a "•" character
    /// - Returns: `NSAttributedString` with orange color applied to the dot
    private func getStyledText(_ text: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        if let dotRange = text.range(of: "•") {
            let nsRange = NSRange(dotRange, in: text)
            attributed.addAttribute(.foregroundColor, value: UIColor.orange, range: nsRange)
        }
        return attributed
    }
}
