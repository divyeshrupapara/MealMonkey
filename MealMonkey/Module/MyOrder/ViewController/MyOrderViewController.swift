import UIKit

/// ViewController to display the user's current orders and allow checkout
class MyOrderViewController: UIViewController {
    
    /// ImageView to display the restaurant image
    @IBOutlet weak var imgRestaurant: UIImageView!
    
    /// Label to show restaurant location
    @IBOutlet weak var lblLocation: UILabel!
    
    /// Label to display subtotal of the orders
    @IBOutlet weak var lblSubTotal: UILabel!
    
    /// Label to display delivery cost
    @IBOutlet weak var lblDeliveryCost: UILabel!
    
    /// Checkout button
    @IBOutlet weak var btnCheckOut: UIButton!
    
    /// TableView to list all ordered items
    @IBOutlet weak var tblMyOrder: UITableView!
    
    /// Label to display total amount including delivery
    @IBOutlet weak var lblTotal: UILabel!
    
    /// Array holding ordered products
    var ordersProducts: [ProductModel] = []
    
    /// Delivery cost for the order
    var floatDeliveryCost: Double = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation title with back button
        setLeftAlignedTitleWithBack("My Order",
                                    target: self,
                                    action: #selector(btnBackTapped))
        
        // Apply style to the checkout button
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnCheckOut])
        
        // Calculate and display totals
        calculateTotals()
        
        // Setup tableView
        tblMyOrder.showsVerticalScrollIndicator = false
        tblMyOrder.register(UINib(nibName: Main.CellIdentifiers.MyOrderTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.MyOrderTableViewCell)
        tblMyOrder.reloadData()
    }
    
    /// Calculates subtotal, delivery cost, and total amount
    func calculateTotals() {
        let subtotal = ordersProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty!)) }
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", floatDeliveryCost))"
        lblTotal.text = "$\(String(format: "%.2f", subtotal + floatDeliveryCost))"
    }
    
    /// Handles back button tap
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Handles checkout button tap
    /// Passes subtotal, delivery cost, and discount to CheckoutViewController
    @IBAction func btnCheckOutClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.MoreStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.CheckoutViewController) as? CheckoutViewController {
            
            // Calculate subtotal from current orders
            let subtotal = ordersProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 0)) }
            let deliveryCost = floatDeliveryCost
            let discount = 5.0 // or any logic to calculate discount
            
            // Pass data to CheckoutViewController
            VC.subtotal = subtotal
            VC.deliveryCost = deliveryCost
            VC.discount = discount
            
            // Navigate to CheckoutViewController
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
