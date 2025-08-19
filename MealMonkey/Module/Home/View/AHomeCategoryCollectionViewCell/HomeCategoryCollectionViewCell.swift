import UIKit

// MARK: - Home Category Collection View Cell
class HomeCategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply styling to category image view
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgCategory])
    }
    
    // MARK: - Configure Cell
    
    /// Configure the cell with category data
    /// - Parameter category: ProductModel object representing the category
    func categoryConfigureCell(category: ProductModel) {
        lblCategory.text = category.objProductCategory.rawValue
        imgCategory.image = UIImage(named: category.strProductImage)
    }
}
