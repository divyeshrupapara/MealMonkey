import UIKit

class RecentItemsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgRecentItem: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblTotalRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgRecentItem])
    }
    
    func recentItemConfigureCell(product: ProductModel) {
        lblFoodName.text = product.strProductName
        lblFoodType.text = product.objProductType.rawValue
        lblFoodRating.text = "\(product.floatProductRating)"
        lblTotalRating.text = "\(product.intTotalNumberOfRatings)"
        imgRecentItem.image = UIImage(named: product.strProductImage)
    }
}
