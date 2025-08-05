import UIKit

class MoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var viewMain: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle(textfield: [imgMenu])
        viewMain.layer.cornerRadius = 7
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureMenuCell(more: ClassMore){
        
        imgMenu.image = UIImage(named: more.imgMenu)
        lblMenu.text = more.strMoreName
    }
    
    func viewStyle(textfield: [UIView]){
        
        for item in textfield {
            item.viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray)
        }
    }
}
