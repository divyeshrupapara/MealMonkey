import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgMostPopular: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodRating: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgMostPopular])
    }
    
    func mostPopularConfigureCell(product: ProductModel) {
        lblFoodName.text = product.strProductName
        lblFoodCategory.text = product.objProductCategory.rawValue
        lblFoodRating.text = "\(product.floatProductRating)"
        imgMostPopular.image = UIImage(named: product.strProductImage)
    }
}
