import UIKit

/// UICollectionViewCell subclass representing a single page in the onboarding collection view.
class CollectionViewCellNextPageCollectionViewCell: UICollectionViewCell {
    
    /// UIImageView to display the page image.
    @IBOutlet weak var imgNextPage: UIImageView!
    
    /// Called after the cell has been loaded from the nib.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     Configures the cell with data from a NextPageClass object.
     
     - Parameter nextPage: The NextPageClass object containing the image to display.
     */
    func configureCell(nextPage: NextPageClass) {
        
        imgNextPage.image = UIImage(named: nextPage.strImage)
    }
}
