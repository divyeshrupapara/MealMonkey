import UIKit

class AboutUsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblText2: UILabel!
    @IBOutlet weak var lblTimezone: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var timezoneWidth: NSLayoutConstraint!
    @IBOutlet weak var stackViewLeading: NSLayoutConstraint!
    @IBOutlet weak var stackViewTrailing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellAboutUs(details: AboutModel){
        
        lblText.text = details.strText
        lblText2.isHidden = true
        lblTimezone.isHidden = true
        btnStar.isHidden = true
        timezoneWidth.constant = 0
        stackViewLeading.constant = 9
    }
    
    func configureCellNotifications(details: AboutModel){
        
        lblText.text = details.strText
        lblText2.text = details.strTimezone
        lblTimezone.isHidden = true
        btnStar.isHidden = true
        timezoneWidth.constant = 0
    }
     
    func configureCellInbox(details: AboutModel){
        
        lblText.text = details.strText
        lblText2.text = details.strText2
        lblTimezone.text = details.strRightSideText
        btnStar.isHidden = false
        stackViewLeading.constant = 5
        stackViewTrailing.constant = 12
    }
    
    @IBAction func btnStarClick(_ sender: Any) {
    }
}
