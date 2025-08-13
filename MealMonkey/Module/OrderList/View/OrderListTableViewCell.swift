import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgFirstFood: UIImageView!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblAddedProducts: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgFirstFood])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func orderListConfigureCell(products: [ProductModel], orderNumber: Int) {
        lblOrderNo.text = "Order #\(orderNumber)"
        
        let productNames = products.map { $0.strProductName }.joined(separator: ", ")
        lblAddedProducts.text = productNames
        
        let totalPrice = products.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 0)) }
        lblTotal.text = "Total: ₹\(String(format: "%.2f", totalPrice))"
        
        if let firstImage = products.first?.strProductImage {
            imgFirstFood.image = UIImage(named: firstImage)
        }
    }
}
