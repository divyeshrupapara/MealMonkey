import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCartView: UITableView!
    
    var cartItems: [ProductModel] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrCart ?? []
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Cart Page", target: self, action: #selector(btnBackTapped))
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnPlaceOrder])
        
        tblCartView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
    }
    
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
         if !appDelegate.arrCart.isEmpty {
             // Save the current cart as a new order
             appDelegate.arrOrders.append(appDelegate.arrCart)
             
             // Clear the cart
             appDelegate.arrCart.removeAll()
         }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
