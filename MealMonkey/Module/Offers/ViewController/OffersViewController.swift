import UIKit

class OffersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setLeftAlignedTitle("Latest Offers")
        setCartButton(target: self, action: #selector(btnCartTapped))
    }
    
    @objc func btnCartTapped() {
    }
}
