import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtSearchFood: UITextField!       /// Search bar for food
    @IBOutlet weak var tblHome: UITableView!            /// Main table view displaying home content
    @IBOutlet weak var btnHomeLocation: UIButton!       /// Button to show/change location
    @IBOutlet weak var lblNoItem: UILabel!              /// Label to show when no items found
    
    // MARK: - Properties
    let productManager = ProductDataManager.shared      /// Singleton for managing products
    var filteredProducts: [ProductModel] = []           /// Products filtered by search
    var searchQuery: String = ""                        /// Current search query
    var isSearching = false                             /// Flag to track if searching
    var currentUser: User?                              /// Currently logged-in user
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoItem.isHidden = true
        btnHomeLocation.titleLabel?.numberOfLines = 0
        
        /// Setup cart button in navigation bar
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        /// Apply UI styles to search text field
        viewStyle(cornerRadius: txtSearchFood.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchFood])
        setPadding.setPadding(left: 34, right: 34, textfield: [txtSearchFood])
        
        /// Configure table view
        tblHome.showsVerticalScrollIndicator = false
        tblHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        /// Fetch products from API
        ApiServices.fetchProducts { [weak self] products in
            ProductDataManager.shared.setProductsFromAPI(products)
            self?.tblHome.reloadData()
        }
        
        /// Load current user data
        loadUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Setup cart button in navigation bar
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        /// Ensure tab bar is visible
        self.tabBarController?.tabBar.isHidden = false
        
        /// Reload table view
        tblHome.reloadData()
        
        /// Update location button if saved address exists
        if let savedAddress = UserDefaults.standard.string(forKey: "lastSelectedAddress") {
            btnHomeLocation.setTitle(savedAddress, for: .normal)
        }
    }
    
    // MARK: - User Data
    /// Load user information from Core Data
    func loadUserData() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            currentUser = user
            setLeftAlignedTitle("Good morning \(user.name ?? "")!")
        }
    }
    
    // MARK: - Actions
    /// Navigate to cart screen
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Handle home location button tap
    @IBAction func btnHomeLocation(_ sender: Any) {
        /// TODO: Implement location selection
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
