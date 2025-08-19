import UIKit

/// Custom UITableViewCell used for About Us, Notifications, and Inbox sections
class AboutUsTableViewCell: UITableViewCell {

    /// Main text label
    @IBOutlet weak var lblText: UILabel!
    
    /// Secondary text label (used for notifications and inbox)
    @IBOutlet weak var lblText2: UILabel!
    
    /// Label showing timezone or right-side text
    @IBOutlet weak var lblTimezone: UILabel!
    
    /// Star button (used in Inbox)
    @IBOutlet weak var btnStar: UIButton!
    
    /// Constraint for timezone width
    @IBOutlet weak var timezoneWidth: NSLayoutConstraint!
    
    /// Leading constraint of the stack view
    @IBOutlet weak var stackViewLeading: NSLayoutConstraint!
    
    /// Trailing constraint of the stack view
    @IBOutlet weak var stackViewTrailing: NSLayoutConstraint!
    
    /// Called after the view has been loaded from the nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Configures the cell’s selected state
    ///
    /// - Parameters:
    ///   - selected: Boolean indicating if the cell is selected
    ///   - animated: Boolean indicating if the selection is animated
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Cell Configuration Methods

    /// Configures cell for About Us section
    ///
    /// - Parameter details: AboutModel containing text information
    func configureCellAboutUs(details: AboutModel){
        lblText.text = details.strText
        lblText2.isHidden = true
        lblTimezone.isHidden = true
        btnStar.isHidden = true
        timezoneWidth.constant = 0
        stackViewLeading.constant = 9
    }
    
    /// Configures cell for Notifications section
    ///
    /// - Parameter details: AboutModel containing text and timezone
    func configureCellNotifications(details: AboutModel){
        lblText.text = details.strText
        lblText2.text = details.strTimezone
        lblTimezone.isHidden = true
        btnStar.isHidden = true
        timezoneWidth.constant = 0
    }
     
    /// Configures cell for Inbox section
    ///
    /// - Parameter details: AboutModel containing main text, secondary text, and right-side text
    func configureCellInbox(details: AboutModel){
        lblText.text = details.strText
        lblText2.text = details.strText2
        lblTimezone.text = details.strRightSideText
        btnStar.isHidden = false
        stackViewLeading.constant = 5
        stackViewTrailing.constant = 12
    }
    
    /// Action for star button click in Inbox
    @IBAction func btnStarClick(_ sender: Any) {
    }
}
