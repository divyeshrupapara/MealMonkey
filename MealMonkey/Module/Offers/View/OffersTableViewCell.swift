import UIKit

/// Custom UITableViewCell to display offer information
class OffersTableViewCell: UITableViewCell {

    /// UIImageView to display the offer image
    @IBOutlet weak var imgOffer: UIImageView!
    
    /// UILabel to display the offer title
    @IBOutlet weak var lblOfferTitle: UILabel!
    
    /// UIButton representing the star (rating) button
    @IBOutlet weak var btnStar: UIButton!
    
    /// UILabel to display the rating value
    @IBOutlet weak var lblRating: UILabel!
    
    /// UILabel to display the number of raters
    @IBOutlet weak var lblRater: UILabel!
    
    /// UILabel to display the type/variety of food
    @IBOutlet weak var lblFoodVariety: UILabel!
    
    /// Called when the cell is loaded from Nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Called when the cell is selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /**
     Action method when star button is clicked.
     
     - Parameter sender: The button that was clicked.
     */
    @IBAction func btnStarClick(_ sender: Any) {
    }
    
    /**
     Configures the cell with the given OfferModel data.
     
     - Parameter offer: The OfferModel containing data for the cell.
     */
    func offerConfigureCell(offer: OfferModel) {
        imgOffer.image = UIImage(named: offer.imgOffer ?? "")
        lblOfferTitle.text = offer.strOfferTitle
        lblRating.text = "\(offer.intRating ?? 0.0)"
        lblRater.text = "(\(offer.intRater ?? 0) ratings)"
        lblFoodVariety.text = offer.strFoodVariety
    }
}
