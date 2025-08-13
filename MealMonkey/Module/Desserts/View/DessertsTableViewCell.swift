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
        DispatchQueue.main.async {
             self.lblDessertTitle.text = dessert.strProductName
             self.lblText.attributedText = self.getStyledText(dessert.strProductDescription)
             self.lblRating.text = "\(dessert.floatProductRating)"
             self.imgDessert.image = UIImage(named: dessert.strProductImage)
             self.setNeedsLayout()
             self.layoutIfNeeded()
         }
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
