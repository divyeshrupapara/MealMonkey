import UIKit

class AddCardTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var btnSelectCard: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewCell])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func CheckoutConfigureCell(card: PaymentModel) {
        let cardNumber = "\(card.intCardNumber ?? 0)"
        if cardNumber.count >= 4 {
            let last4 = cardNumber.suffix(4)
            lblCardNumber.text = "**** **** **** \(last4)"
        } else {
            lblCardNumber.text = "Invalid Card"
        }
    }
    
    @IBAction func btnSelectCardClick(_ sender: Any) {
    }
}
