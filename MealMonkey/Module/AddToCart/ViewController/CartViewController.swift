import UIKit

/// ViewController to display and manage the user's Cart
class CartViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// Button to place the current order
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    /// TableView displaying cart items
    @IBOutlet weak var tblCartView: UITableView!
    
    /// Label displayed when there are no items in cart
    @IBOutlet weak var lblNoItem: UILabel!
    
    // MARK: - Properties
    
    /// Array of products currently in cart
    var cartItems: [ProductModel] = []
    
    /// Currently logged-in user
    var currentUser: User?
    
    // MARK: - Lifecycle Methods
    
    /// Called after the controller's view has been loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initially hide order button and no-item label
        btnPlaceOrder.isHidden = true
        lblNoItem.isHidden = true
        
        // Setup navigation title with back button
        setLeftAlignedTitleWithBack("Cart Page", target: self, action: #selector(btnBackTapped))
        
        // Apply corner radius styling to Place Order button
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnPlaceOrder])
        
        // Register custom table view cell
        tblCartView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
        // Load cart items
        loadCart()
    }
    
    /// Called before the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCart()
    }
    
    // MARK: - Helper Methods
    
    /// Load cart items for the current user
    func loadCart() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            self.currentUser = user
            self.cartItems = CoreDataManager.shared.fetchCart(for: user)
        } else {
            self.cartItems = []
        }
        
        // Show/hide UI elements based on cart contents
        lblNoItem.isHidden = !cartItems.isEmpty
        btnPlaceOrder.isHidden = cartItems.isEmpty
        
        // Reload TableView
        tblCartView.reloadData()
    }
    
    // MARK: - IBActions
    
    /// Called when Place Order button is tapped
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        guard let user = currentUser, !cartItems.isEmpty else { return }
        
        // Save current cart as a new order
        CoreDataManager.shared.saveOrder(for: user, products: cartItems)
        
        // Clear the cart
        CoreDataManager.shared.clearCart(for: user)
        
        // Reload cart UI
        loadCart()
        
        // Navigate to Order List screen
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "OrderListViewController") as? OrderListViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Called when back button is tapped
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
