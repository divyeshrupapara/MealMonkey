import UIKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCardCategory: UIImageView!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var btnCardDelete: UIButton!
    
    var deleteCard: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: btnCardDelete.frame.size.height / 2, borderWidth: 1, borderColor: .buttonBackground, textField: [btnCardDelete])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cardConfigureCell(card: PaymentModel) {
        let cardNumber = "\(card.intCardNumber ?? 0)"
        if cardNumber.count >= 4 {
            let last4 = cardNumber.suffix(4)
            lblCardNumber.text = "**** **** **** \(last4)"
        } else {
            lblCardNumber.text = "Invalid Card"
        }
    }
    
    @IBAction func btnCardDeleteClick(_ sender: Any) {
        deleteCard?()
    }
}
