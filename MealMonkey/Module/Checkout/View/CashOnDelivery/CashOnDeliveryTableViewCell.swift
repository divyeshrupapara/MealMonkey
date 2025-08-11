import UIKit

class CashOnDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewCell])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
