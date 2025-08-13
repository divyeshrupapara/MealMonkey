import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var tblOrderList: UITableView!
    @IBOutlet weak var lblNoItem: UILabel!
    
    var orders: [[ProductModel]] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrOrders ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if orders.count == 0 {
            lblNoItem.isHidden = false
        } else {
            lblNoItem.isHidden = true
        }
        
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(btnBackTapped))
        
        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
        tblOrderList.reloadData()
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
