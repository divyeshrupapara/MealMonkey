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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        // Register custom table view cell
        tblMoreOpions.showsVerticalScrollIndicator = false
        tblMoreOpions.backgroundColor = .clear
        tblMoreOpions.register(
            UINib(nibName: Main.CellIdentifiers.AboutUsTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.AboutUsTableViewCell
        )
        
        applyTheme()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: .themeChanged,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurePage()   // reload localized content whenever view appears
    }
    
    // MARK: - Setup Page
    
    private func configurePage() {
        switch objPageType {
        case .PayMent:
            print("Payment")
        case .MyOrders:
            print("My Orders")
        case .Notification:
            arrCurrent = AboutModel.addNotificationData()
            setLeftAlignedTitleWithBack(L("notification_screen_title"),
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self, action: #selector(btnCartTapped))
        case .Inbox:
            arrCurrent = AboutModel.addInboxData()
            setLeftAlignedTitleWithBack(L("inbox_screen_title"),
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self, action: #selector(btnCartTapped))
        case .AboutUs:
            arrCurrent = AboutModel.addAboutData()
            setLeftAlignedTitleWithBack(L("about_screen_title"),
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self, action: #selector(btnCartTapped))
        case .WishList:
            print("Wishlist")
        }
        
        tblMoreOpions.reloadData() // refresh table with updated strings
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        self.view.backgroundColor = theme.AppBackgroundColor
        self.navigationController?.navigationBar.backgroundColor = theme.AppBackgroundColor
        self.tabBarController?.tabBar.backgroundColor = theme.AppBackgroundColor
    }
    
    // MARK: - Button Actions
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: Main.StoryBoard.MenuStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(
            withIdentifier: Main.ViewController.CartViewController
        ) as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
