import UIKit

class OffersTableViewCell: UITableViewCell {

    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var lblOfferTitle: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRater: UILabel!
    @IBOutlet weak var lblCafe: UILabel!
    @IBOutlet weak var lblFoodVariety: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnStarClick(_ sender: Any) {
    }
    
    func offerConfigureCell(offer: OfferModel) {
        imgOffer.image = UIImage(named: offer.imgOffer ?? "")
        lblOfferTitle.text = offer.strOfferTitle
        lblRating.text = "\(offer.intRating ?? 0.0)"
        lblRater.text = "(\(offer.intRater ?? 0) ratings)"
        lblCafe.text = offer.strCafeName
        lblFoodVariety.text = offer.strFoodVariety
    }
}
