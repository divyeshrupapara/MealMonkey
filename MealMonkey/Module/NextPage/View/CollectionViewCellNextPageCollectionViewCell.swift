import UIKit

class CollectionViewCellNextPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgNextPage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(nextPage: NextPageClass) {
        
        imgNextPage.image = UIImage(named: nextPage.strImage)
    }
}
