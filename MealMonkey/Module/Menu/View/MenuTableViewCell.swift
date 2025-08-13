import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategoryTitle: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    @IBOutlet weak var viewMainMenu: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(category: ClassCategory){
        
        imgCategory.image = UIImage(named: category.imgCategory)
        lblCategoryTitle.text = category.strCategoryName
        lblItems.text = "\(category.intItems) Items"
    }
}
