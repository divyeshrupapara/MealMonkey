import UIKit

class MoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var viewMain: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgMenu.layer.cornerRadius = 28
        viewMain.layer.cornerRadius = 7
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureMenuCell(more: ClassMore){
        
        imgMenu.image = UIImage(named: more.imgMenu)
        lblMenu.text = more.strMoreName
    }
}
