import UIKit

class MyOrderViewController: UIViewController {
    
    @IBOutlet weak var imgRestaurant: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var tblMyOrder: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    
    var ordersProducts: [ProductModel] = []
    var floatDeliveryCost: Double = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("My Order",
                                    target: self,
                                    action: #selector(btnBackTapped))
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnCheckOut])
        
        calculateTotals()
        
        tblMyOrder.register(UINib(nibName: "MyOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrderTableViewCell")
        tblMyOrder.reloadData()
    }
    
    func calculateTotals() {
            let subtotal = ordersProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty!)) }
            lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
            lblDeliveryCost.text = "$\(String(format: "%.2f", floatDeliveryCost))"
            lblTotal.text = "$\(String(format: "%.2f", subtotal + floatDeliveryCost))"
        }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckOutClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
          if let VC = storyboard.instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController {
              
              // Calculate subtotal from current orders
              let subtotal = ordersProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 0)) }
              let deliveryCost = floatDeliveryCost
              let discount = 5.0 // or any logic to calculate discount
              
              VC.subtotal = subtotal
              VC.deliveryCost = deliveryCost
              VC.discount = discount
              
              self.navigationController?.pushViewController(VC, animated: true)
          }
    }
}
