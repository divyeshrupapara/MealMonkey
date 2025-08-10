import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgMostPopular: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgMostPopular])
    }
}
