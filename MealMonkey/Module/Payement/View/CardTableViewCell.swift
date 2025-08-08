import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCardCategory: UIImageView!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var btnCardDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: btnCardDelete.frame.size.height / 2, borderWidth: 1, borderColor: .buttonBackground, textField: [btnCardDelete])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCardDeleteClick(_ sender: Any) {
    }
}
