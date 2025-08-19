import UIKit

// MARK: - Most Popular Collection View Cell
class MostPopularCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imgMostPopular: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Apply styling to image view
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgMostPopular])
    }
    
    // MARK: - Configure Cell
    
    /// Configure the cell with product data
    /// - Parameter product: ProductModel object representing the food item
    func mostPopularConfigureCell(product: ProductModel) {
        lblFoodName.text = product.strProductName
        lblFoodCategory.text = product.objProductCategory.rawValue
        lblFoodRating.text = "\(product.floatProductRating)"
        imgMostPopular.image = UIImage(named: product.strProductImage)
    }
}
