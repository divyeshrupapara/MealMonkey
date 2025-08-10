import UIKit

class OffersViewController: UIViewController {

    @IBOutlet weak var btnCheckOffer: UIButton!
    @IBOutlet weak var tblOffers: UITableView!
    
    var arrOffer: [OfferModel] = OfferModel.addOffers()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewStyle(cornerRadius: btnCheckOffer.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnCheckOffer])
        
        setLeftAlignedTitle("Latest Offers")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblOffers.showsVerticalScrollIndicator = false
        tblOffers.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }
}
