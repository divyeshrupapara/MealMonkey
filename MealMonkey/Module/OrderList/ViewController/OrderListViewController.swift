import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var tblOrderList: UITableView!
    @IBOutlet weak var lblNoItem: UILabel!
    
    var orders: [[ProductModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserOrders()
        
        lblNoItem.isHidden = !orders.isEmpty
        
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(btnBackTapped))
        
        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
        tblOrderList.reloadData()
    }
    
    private func loadUserOrders() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            orders = CoreDataManager.shared.fetchOrders(for: user)
        } else {
            orders = []
        }
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
