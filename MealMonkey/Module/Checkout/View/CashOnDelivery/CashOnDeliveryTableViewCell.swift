import UIKit

/// UITableViewCell subclass for displaying and selecting Cash On Delivery (COD) option
class CashOnDeliveryTableViewCell: UITableViewCell {

    /// The main container view of the cell
    @IBOutlet weak var viewCell: UIView!
    
    /// Button to select the COD payment option
    @IBOutlet weak var btnSelectCOD: UIButton!
    
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
    
    /// Action triggered when the user taps the select COD button
    @IBAction func btnSelectCODClick(_ sender: Any) {
    }
}
