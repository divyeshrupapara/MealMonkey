import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPopular: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func popularConfigureCell(product: ProductModel) {
        lblFoodName.text = product.strProductName
        lblFoodRating.text = "\(product.floatProductRating)"
        lblFoodType.text = "\(product.objProductType.rawValue)"
        imgPopular.image = UIImage(named: product.strProductImage)
    }
}
