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
    
    func dessertConfigureCell(dessert: DessertsModel) {
        lblDessertTitle.text = dessert.strDessertsTitle
        lblText.attributedText = getStyledText(dessert.strText ?? "")
        lblRating.text = "\(dessert.floatRating ?? 0.0)"
        imgDessert.image = UIImage(named: dessert.imgDesserts ?? "")
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
