import UIKit

/// View controller to display the menu categories and search functionality
class MenuViewController: UIViewController {
    
    /// Text field for searching food items
    @IBOutlet weak var txtSearchFood: UITextField!
    
    /// Table view displaying the list of categories
    @IBOutlet weak var tblCategory: UITableView!
    
    /// Background view for the table view
    @IBOutlet weak var tblBackView: UIView!
    
    /// Label displayed when no items are available
    @IBOutlet weak var lblNoItem: UILabel!
    
    /// Array of categories to display
    var arrCategory: [ClassCategory] = ClassCategory.addCategory()
    
    /// Filtered array of categories based on search
    var arrFilterCategory: [ClassCategory] = []
    
    /// Called after the controller's view has been loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Show navigation bar
        self.navigationController?.isNavigationBarHidden = false
        
        /// Set navigation title and cart button
        setLeftAlignedTitle("Menu")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        /// Apply corner radius to the background view
        applyCornerRadiusTLBR()
        
        /// Style the search text field
        viewStyle(cornerRadius: txtSearchFood.frame.size.height/2 , borderWidth: 0, borderColor: .systemGray, textField: [txtSearchFood])
        setPadding(textfield: [txtSearchFood])
        
        /// Configure table view appearance
        tblCategory.showsVerticalScrollIndicator = false
        tblCategory.backgroundColor = .clear
        tblCategory.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        /// Initialize filtered category array and hide "No Item" label
        arrFilterCategory = arrCategory
        lblNoItem.isHidden = true
    }
    
    /// Action triggered when the cart button is tapped
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Apply corner radius to top-left and bottom-right corners of the background view
    func applyCornerRadiusTLBR() {
        tblBackView.layer.cornerRadius = 28
        tblBackView.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
        ]
        tblBackView.clipsToBounds = true
    }
    
    /// Set padding for the given text fields
    /// - Parameter textfield: Array of UITextField objects to apply padding
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
}
