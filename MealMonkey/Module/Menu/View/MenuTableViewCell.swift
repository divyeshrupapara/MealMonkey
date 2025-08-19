import UIKit

/// Custom table view cell to display a menu category
class MenuTableViewCell: UITableViewCell {
    
    /// Image view for the category icon
    @IBOutlet weak var imgCategory: UIImageView!
    
    /// Label for the category title
    @IBOutlet weak var lblCategoryTitle: UILabel!
    
    /// Label showing number of items in the category
    @IBOutlet weak var lblItems: UILabel!
    
    /// Main container view for the cell
    @IBOutlet weak var viewMainMenu: UIView!
    
    /// Called after the cell has been loaded from the nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Configure the appearance of the cell when selected
    /// - Parameters:
    ///   - selected: Whether the cell is selected
    ///   - animated: Whether the selection is animated
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Configure the cell with a given category
    /// - Parameter category: The `ClassCategory` object containing data to display
    func configureCell(category: ClassCategory){
        imgCategory.image = UIImage(named: category.imgCategory)
        lblCategoryTitle.text = category.strCategoryName
        lblItems.text = "\(category.intItems) Items"
    }
}
