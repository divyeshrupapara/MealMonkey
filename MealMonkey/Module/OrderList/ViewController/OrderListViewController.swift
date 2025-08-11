import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var tblOrderList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(btnCartTapped))
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
