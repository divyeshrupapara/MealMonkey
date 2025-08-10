import UIKit

class RecentItemsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgRecentItem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgRecentItem])
    }
}
