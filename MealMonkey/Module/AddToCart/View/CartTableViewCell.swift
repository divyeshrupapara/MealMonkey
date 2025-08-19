import UIKit

/// TableViewCell representing a product in Cart or Wishlist
class CartTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    /// Delete button for removing product from cart
    @IBOutlet weak var btnDelete: UIButton!
    
    /// Label displaying product name
    @IBOutlet weak var lblProductTitle: UILabel!
    
    /// Label displaying quantity
    @IBOutlet weak var lblQty: UILabel!
    
    /// Label displaying product price
    @IBOutlet weak var lblPrice: UILabel!
    
    /// Label displaying product type
    @IBOutlet weak var lblType: UILabel!
    
    /// Label displaying product category
    @IBOutlet weak var lblCategory: UILabel!
    
    /// Product image view
    @IBOutlet weak var imgProduct: UIImageView!
    
    /// Heart button for wishlist toggle
    @IBOutlet weak var btnHeart: UIButton!
    
    // MARK: - Callbacks
    
    /// Closure called when delete button is tapped
    var onDelete: (() -> Void)?
    
    /// Closure called when heart button is toggled
    var onHeartToggle: (() -> Void)?
    
    // MARK: - Lifecycle Methods
    
    /// Called after the cell has been loaded from nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply corner radius styling to product image
        viewStyle.viewStyle(cornerRadius: 20, borderWidth: 0, borderColor: .systemGray, textField: [imgProduct])
    }
    
    /// Called when the cell selection state changes
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBActions
    
    /// Called when delete button is tapped
    @IBAction func btnDeleteClick(_ sender: Any) {
        onDelete?()
    }
    
    /// Called when heart button is tapped
    @IBAction func btnHeartClick(_ sender: Any) {
        onHeartToggle?()
    }
    
    // MARK: - Configuration Methods
    
    /// Configure cell for Cart display
    /// - Parameter product: ProductModel instance
    func configCartCell(product: ProductModel) {
        lblProductTitle.text = product.strProductName
        imgProduct.image = UIImage(named: product.strProductImage)
        lblPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblType.text = product.objProductType.rawValue.capitalized
        lblCategory.text = product.objProductCategory.rawValue
        lblQty.text = "QTY: \(product.intProductQty ?? 1)"
        
        btnHeart.isHidden = true
        btnDelete.isHidden = false
    }
    
    /// Configure cell for Wishlist display
    /// - Parameter product: ProductModel instance
    func configWishlistCell(product: ProductModel) {
        lblProductTitle.text = product.strProductName
        imgProduct.image = UIImage(named: product.strProductImage)
        lblPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblType.text = product.objProductType.rawValue.capitalized
        lblCategory.text = product.objProductCategory.rawValue
        lblQty.text = "QTY: \(product.intProductQty ?? 1)"
        
        btnDelete.isHidden = true
        btnHeart.isHidden = false
        btnHeart.setImage(UIImage(named: "ic_heart"), for: .normal)
    }
}
