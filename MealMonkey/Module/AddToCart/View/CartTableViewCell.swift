import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    var onDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 20, borderWidth: 0, borderColor: .systemGray, textField: [imgProduct])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func btnDeleteClick(_ sender: Any) {
        onDelete?()
    }
    
    func configCartCell(product: ProductModel) {
        lblProductTitle.text = product.strProductName
        imgProduct.image = UIImage(named: product.strProductImage)
        lblPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblType.text = product.objProductType.rawValue.capitalized
        lblCategory.text = product.objProductCategory.rawValue
        lblQty.text = "QTY: \(product.intProductQty ?? 1)"
    }
}
