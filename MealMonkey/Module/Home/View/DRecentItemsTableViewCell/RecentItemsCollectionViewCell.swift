import UIKit

// MARK: - Recent Items Collection View Cell
class RecentItemsCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imgRecentItem: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblTotalRating: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Apply styling to image view
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgRecentItem])
    }
    
    // MARK: - Configure Cell
    
    /// Configure the cell with product data
    /// - Parameter product: ProductModel object representing the recent food item
    func recentItemConfigureCell(product: ProductModel) {
        lblFoodName.text = product.strProductName
        lblFoodType.text = product.objProductType.rawValue
        lblFoodRating.text = "\(product.floatProductRating)"
        lblTotalRating.text = "\(product.intTotalNumberOfRatings)"
        imgRecentItem.image = UIImage(named: product.strProductImage)
    }
}
