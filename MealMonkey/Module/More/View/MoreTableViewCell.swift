import UIKit

/// Table view cell representing a single "More" menu item
class MoreTableViewCell: UITableViewCell {
    
    /// Image view displaying the menu icon
    @IBOutlet weak var imgMenu: UIImageView!
    
    /// Label displaying the menu item name
    @IBOutlet weak var lblMenu: UILabel!
    
    /// Main container view for the cell
    @IBOutlet weak var viewMain: UIView!
    
    /// Called when the cell is loaded from the nib/storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply corner radius to image and main view
        imgMenu.layer.cornerRadius = 28
        viewMain.layer.cornerRadius = 7
    }
    
    /// Called when the cell is selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Configures the cell with a `ClassMore` menu item
    /// - Parameter more: The `ClassMore` object containing menu data
    func configureMenuCell(more: ClassMore){
        imgMenu.image = UIImage(named: more.imgMenu)
        lblMenu.text = more.strMoreName
    }
}
