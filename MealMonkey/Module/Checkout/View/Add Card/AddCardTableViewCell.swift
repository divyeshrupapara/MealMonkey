import UIKit

/// UITableViewCell subclass for displaying and selecting a saved card in checkout
class AddCardTableViewCell: UITableViewCell {

    /// The main container view of the cell
    @IBOutlet weak var viewCell: UIView!
    
    /// Label to display masked card number
    @IBOutlet weak var lblCardNumber: UILabel!
    
    /// Button to select this card for checkout
    @IBOutlet weak var btnSelectCard: UIButton!
    
    /// Called when the cell is loaded from Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply rounded corners and border styling to the cell view
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewCell])
    }

    /// Handles selection state changes
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Configures the cell with card details
    /// - Parameter card: The PaymentModel object containing card data
    func CheckoutConfigureCell(card: PaymentModel) {
        let cardNumber = "\(card.intCardNumber ?? 0)"
        if cardNumber.count >= 4 {
            let last4 = cardNumber.suffix(4)
            lblCardNumber.text = "**** **** **** \(last4)"
        } else {
            lblCardNumber.text = "Invalid Card"
        }
    }
    
    /// Action triggered when the user taps the select card button
    @IBAction func btnSelectCardClick(_ sender: Any) {
    }
}
