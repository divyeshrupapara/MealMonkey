import UIKit

/// UIViewController subclass for displaying a list of user orders
class OrderListViewController: UIViewController {
    
    /// UITableView displaying the orders
    @IBOutlet weak var tblOrderList: UITableView!
    
    /// Array of orders, where each order is an array of ProductModel
    var orders: [[ProductModel]] = []
    
    /// Called after the view has been loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Load orders from Core Data for the logged-in user
        loadUserOrders()
        
        /// Show or hide the "no item" label depending on whether orders exist
        if orders.isEmpty {
            LottieAnimationHelper.showEmptyState(on: tblOrderList,
                                                     animationName: "Shopping checlist app!",
                                                     message: "Order List is Empty")
        } else {
            LottieAnimationHelper.removeEmptyState(from: tblOrderList)
        }
        
        /// Set the navigation bar title with a back button
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(btnBackTapped))
        
        /// Register the custom table view cell
        tblOrderList.register(UINib(nibName: Main.CellIdentifiers.OrderListTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.OrderListTableViewCell)
        
        /// Reload table view to display orders
        tblOrderList.reloadData()
    }
    
    /// Loads orders for the currently logged-in user from Core Data
    private func loadUserOrders() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            orders = CoreDataManager.shared.fetchOrders(for: user)
        } else {
            orders = []
        }
    }
    
    /// Shows the main tab bar controller
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: Main.StoryBoard.HomeStoryboard, bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: Main.ViewController.MainTabViewController) as? UITabBarController {
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 4
            }
        }
    }
    
    /// Action called when the back button is tapped
    @objc func btnBackTapped() {
        showMainTabBar()
    }
}
