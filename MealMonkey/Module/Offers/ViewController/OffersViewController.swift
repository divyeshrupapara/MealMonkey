import UIKit

/// ViewController to display latest offers in a table view
class OffersViewController: UIViewController {

    /// UIButton to check the current offer
    @IBOutlet weak var btnCheckOffer: UIButton!
    
    /// UITableView to display a list of offers
    @IBOutlet weak var tblOffers: UITableView!
    
    /// Array of OfferModel objects representing available offers
    var arrOffer: [OfferModel] = OfferModel.addOffers()
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style the "Check Offer" button
        viewStyle(cornerRadius: btnCheckOffer.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnCheckOffer])
        
        // Set the navigation title aligned to left
        setLeftAlignedTitle("Latest Offers")
        
        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        // Configure the table view
        tblOffers.showsVerticalScrollIndicator = false
        tblOffers.register(UINib(nibName: Main.CellIdentifiers.OffersTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.OffersTableViewCell)
    }
    
    /**
     Action method when cart button is tapped.
     Pushes the CartViewController onto the navigation stack.
     */
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: Main.StoryBoard.MenuStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.CartViewController) as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
