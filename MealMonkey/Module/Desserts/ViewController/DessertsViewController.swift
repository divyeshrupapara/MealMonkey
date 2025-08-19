import UIKit

/// ViewController responsible for displaying desserts, beverages, or food items
class DessertsViewController: UIViewController {

    /// UITextField for searching desserts
    @IBOutlet weak var txtSearchDesserts: UITextField!
    
    /// UITableView to display the list of desserts
    @IBOutlet weak var tblDesserts: UITableView!
    
    /// UILabel displayed when no items match the search/filter
    @IBOutlet weak var lblNoItem: UILabel!
    
    /// Shared product data manager
    let productManager = ProductDataManager.shared
    
    /// Currently selected product type (Desserts, Food, Beverages)
    var selectedProductType: ProductType = .Desserts

    /// Array of products filtered by the selected type
    var arrProducts: [ProductModel] {
        return productManager.products(for: selectedProductType)
    }
    
    /// All products for the selected type
    var allProducts: [ProductModel] = []
    
    /// Filtered products after search
    var filteredProducts: [ProductModel] = []
    
    /// Called after the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide "No Item" label initially
        lblNoItem.isHidden = true
        
        // Apply rounded corner style to search text field
        viewStyle(cornerRadius: txtSearchDesserts.frame.size.height/2,
                  borderWidth: 0,
                  borderColor: .systemGray,
                  textField: [txtSearchDesserts])
        
        // Add left/right padding to search text field
        setPadding.setPadding(left: 34, right: 34, textfield: [txtSearchDesserts])
        
        // Set delegate for search field
        txtSearchDesserts.delegate = self
        
        // Load all products of selected type
        allProducts = productManager.products(for: selectedProductType)
        filteredProducts = allProducts
        
        // Set navigation title based on selected product type
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack(
                "Food",
                target: self,
                action: #selector(btnBackTapped)
            )
            tblDesserts.reloadData()

        case .Beverages:
            setLeftAlignedTitleWithBack(
                "Beverages",
                target: self,
                action: #selector(btnBackTapped)
            )
            tblDesserts.reloadData()

        case .Desserts:
            setLeftAlignedTitleWithBack(
                "Desserts",
                target: self,
                action: #selector(btnBackTapped)
            )
            tblDesserts.reloadData()
        }
        
        // Add cart button to navigation bar
        setCartButton(target: self,
                      action: #selector(btnCartTapped))
        
        // Register custom cell for desserts
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil),
                             forCellReuseIdentifier: "DessertsTableViewCell")
        tblDesserts.reloadData()
    }
    
    /// Handles back button tap
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Handles cart button tap, navigates to CartViewController
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
