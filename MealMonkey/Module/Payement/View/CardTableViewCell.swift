import UIKit

/// Custom UITableViewCell to display payment card details
class CardTableViewCell: UITableViewCell {
    
    /// Image view for card type or category (e.g., Visa, MasterCard)
    @IBOutlet weak var imgCardCategory: UIImageView!
    
    /// Label displaying the masked card number
    @IBOutlet weak var lblCardNumber: UILabel!
    
    /// Button to delete the card
    @IBOutlet weak var btnCardDelete: UIButton!
    
    /// Closure executed when the delete button is tapped
    var deleteCard: (() -> Void)?
    
    /// Called after the view has been loaded from the nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply circular style to the delete button
        viewStyle.viewStyle(cornerRadius: btnCardDelete.frame.size.height / 2, borderWidth: 1, borderColor: .buttonBackground, textField: [btnCardDelete])
    }
    
    /// Configures the cell's selection behavior
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Configures the cell with a given payment card
    /// - Parameter card: PaymentModel object containing card information
    func cardConfigureCell(card: PaymentModel) {
        let cardNumber = "\(card.intCardNumber ?? 0)"
        if cardNumber.count >= 4 {
            let last4 = cardNumber.suffix(4)
            lblCardNumber.text = "**** **** **** \(last4)"
        } else {
            lblCardNumber.text = "Invalid Card"
        }
    }
    
    /// Action triggered when the delete button is tapped
    @IBAction func btnCardDeleteClick(_ sender: Any) {
        deleteCard?()
    }
}
