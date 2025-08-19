import UIKit

/// ViewController to display About Us, Notifications, Inbox, and other related pages
class AboutUsViewController: UIViewController {
    
    /// Table view to display list of AboutModel items
    @IBOutlet weak var tblMoreOpions: UITableView!
    
    /// Array holding current page data
    var arrCurrent: [AboutModel] = []
    
    /// Enum representing the type of page to display
    var objPageType: PageType = .AboutUs
    
    // MARK: - Lifecycle Methods
    
    /// Called after the view has been loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        // Configure the page based on its type
        switch objPageType {
        case .PayMent:
            print("Payment")
        case .MyOrders:
            print("My Orders")
        case .Notification:
            arrCurrent = AboutModel.addNotificationData()
            setLeftAlignedTitleWithBack("Notification",
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self, action: #selector(btnCartTapped))
        case .Inbox:
            arrCurrent = AboutModel.addInboxData()
            setLeftAlignedTitleWithBack("Inbox",
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self,
                          action: #selector(btnCartTapped))
        case .AboutUs:
            arrCurrent = AboutModel.addAboutData()
            setLeftAlignedTitleWithBack("About Us",
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self,
                          action: #selector(btnCartTapped))
        case .WishList:
            print("Wishlist")
        }
        
        // Register custom table view cell
        tblMoreOpions.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
    }
    
    // MARK: - Button Actions
    
    /// Handles back button tap action
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Handles cart button tap action, pushes CartViewController
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
