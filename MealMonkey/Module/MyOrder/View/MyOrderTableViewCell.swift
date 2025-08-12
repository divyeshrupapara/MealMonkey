import UIKit

class MyOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFoodNameXQty: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func myOrderConfigureCell(order: ProductModel) {
        lblFoodNameXQty.text = order.strProductName + " x "+"\(order.intProductQty!)"
        lblFoodPrice.text = "$ \(String(format: "%.2f", order.doubleProductPrice * Double(order.intProductQty ??  0)))"
    }
}
