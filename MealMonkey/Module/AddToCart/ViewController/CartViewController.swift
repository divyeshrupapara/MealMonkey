import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCartView: UITableView!
    @IBOutlet weak var lblNoItem: UILabel!
    
    var cartItems: [ProductModel] = []
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPlaceOrder.isHidden = true
        lblNoItem.isHidden = true
        
        setLeftAlignedTitleWithBack("Cart Page", target: self, action: #selector(btnBackTapped))
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnPlaceOrder])
        
        tblCartView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
        loadCart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCart()
    }
    
    func loadCart() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            self.currentUser = user
            self.cartItems = CoreDataManager.shared.fetchCart(for: user)
        } else {
            self.cartItems = []
        }
        
        lblNoItem.isHidden = !cartItems.isEmpty
        btnPlaceOrder.isHidden = cartItems.isEmpty
        tblCartView.reloadData()
    }
    
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        guard let user = currentUser, !cartItems.isEmpty else { return }
        
        // Save current cart as new order
        CoreDataManager.shared.saveOrder(for: user, products: cartItems)
        
        // Clear cart
        CoreDataManager.shared.clearCart(for: user)
        
        // Reload
        loadCart()
        
        // Navigate to OrderList
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "OrderListViewController") as? OrderListViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
