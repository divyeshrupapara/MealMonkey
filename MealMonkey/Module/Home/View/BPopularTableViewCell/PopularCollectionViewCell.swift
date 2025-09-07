import UIKit

// MARK: - Popular Collection View Cell
class PopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblRater: UILabel!
    @IBOutlet weak var lblCafe: UILabel!
    @IBOutlet weak var imgPopular: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: .themeChanged,
            object: nil
        )
        // Cell initialization logic can be added here if needed
    }
    
    // MARK: - Configure Cell
    
    /// Configure the cell with product data
    /// - Parameter product: ProductModel object representing the food item
    func popularConfigureCell(product: ProductModel) {
        lblFoodName.text = product.strProductName
        lblFoodRating.text = "\(product.floatProductRating)"
        lblFoodType.text = "\(product.objProductType.rawValue)"
        imgPopular.image = UIImage(named: product.strProductImage)
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        viewMain.backgroundColor = theme.AppBackgroundColor
        lblFoodName.textColor = theme.PrimaryFontColor
        lblFoodRating.textColor = theme.MainColor
        lblRater.textColor = theme.PlaceholderColor
        lblCafe.textColor = theme.PlaceholderColor
        lblFoodType.textColor = theme.PlaceholderColor
    }
}
