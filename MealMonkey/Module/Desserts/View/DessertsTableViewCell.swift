import UIKit

class DessertsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgDessert: UIImageView!
    @IBOutlet weak var lblDessertTitle: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func dessertConfigureCell(dessert: ProductModel) {
        lblDessertTitle.text = dessert.strProductName
        lblText.attributedText = getStyledText(dessert.strProductDescription)
        lblRating.text = "\(dessert.floatProductRating)"
        imgDessert.image = UIImage(named: dessert.strProductImage)
    }
    
    private func getStyledText(_ text: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        if let dotRange = text.range(of: "•") {
            let nsRange = NSRange(dotRange, in: text)
            attributed.addAttribute(.foregroundColor, value: UIColor.orange, range: nsRange)
        }
        return attributed
    }
}
