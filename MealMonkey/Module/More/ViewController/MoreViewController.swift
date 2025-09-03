import UIKit

/// View controller displaying the "More" menu screen
class MoreViewController: UIViewController {
    
    /// Table view showing the list of "More" menu items
    @IBOutlet weak var tblMenu: UITableView!
    
    /// Array of `ClassMore` objects representing each menu item
    var arrMore: [ClassMore] = ClassMore.addMore()
    
    /// Called after the controller’s view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show navigation bar and set left-aligned title
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitle("More")
        
        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        // Configure table view appearance
        tblMenu.showsVerticalScrollIndicator = false
        tblMenu.register(UINib(nibName: Main.CellIdentifiers.MoreTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.MoreTableViewCell)
    }
    
    /// Called just before the view appears on screen
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    /// Handles tap on the cart button in the navigation bar
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: Main.StoryBoard.MenuStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.CartViewController) as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
