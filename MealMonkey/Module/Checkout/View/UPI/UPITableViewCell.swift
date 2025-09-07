import UIKit

/// UITableViewCell subclass for displaying and selecting UPI payment option
class UPITableViewCell: UITableViewCell {

    @IBOutlet weak var lblUPIId: UILabel!
    /// The main container view of the cell
    @IBOutlet weak var viewCell: UIView!
    
    /// Button to select the UPI payment option
    @IBOutlet weak var btnSelectUPI: UIButton!
    
    /// Called when the cell is loaded from Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: .themeChanged,
            object: nil
        )
        // Apply rounded corners and border styling to the cell view
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewCell])
    }

    /// Handles selection state changes
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        lblUPIId.textColor = theme.PrimaryFontColor
        viewCell.backgroundColor = theme.MoreCellBackgroundColor
    }
    
    /// Action triggered when the user taps the select UPI button
    @IBAction func btnSelectUPIClick(_ sender: Any) {
    }
}
