import UIKit

/// ViewController to display and manage the user's Cart
class CartViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// Button to place the current order
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    /// TableView displaying cart items
    @IBOutlet weak var tblCartView: UITableView!
    
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
        // Setup navigation title with back button
        setLeftAlignedTitleWithBack(
            L("cart_screen_title"),
            target: self,
            action: #selector(btnBackTapped)
        )
        btnPlaceOrder.setTitle(L("cart_btnPlaceOrder"), for: .normal)
        // Apply corner radius styling to Place Order button
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnPlaceOrder])
        
        // Register custom table view cell
        tblCartView.showsVerticalScrollIndicator = false
        tblCartView.backgroundColor = .clear
        tblCartView.register(UINib(nibName: Main.CellIdentifiers.CartTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.CartTableViewCell)
        
        // Load cart items
        loadCart()
        
        applyTheme()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: .themeChanged,
            object: nil
        )
    }
    
    /// Called before the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCart()
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        self.view.backgroundColor = theme.AppBackgroundColor
        self.navigationController?.navigationBar.backgroundColor = theme.AppBackgroundColor
        self.tabBarController?.tabBar.backgroundColor = theme.AppBackgroundColor
        btnPlaceOrder.setTitleColor(theme.AppBackgroundColor, for: .normal)
        btnPlaceOrder.backgroundColor = theme.MainColor
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
        if cartItems.isEmpty {
            LottieAnimationHelper.showEmptyState(on: tblCartView,
                                                     animationName: "Shopping Cart",
                                                     message: L("cart_empty_message"))
        } else {
            LottieAnimationHelper.removeEmptyState(from: tblCartView)
        }
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
        let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.OrderListViewController) as? OrderListViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Called when back button is tapped
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
