import UIKit

/// ViewController responsible for handling the Checkout process
class CheckoutViewController: UIViewController {
    
    /// UIButton to send the order
    @IBOutlet weak var btnSendOrder: UIButton!
    
    /// UITableView to display saved cards and payment options
    @IBOutlet weak var tblCheckOutCard: UITableView!
    
    /// UIButton to add a new card
    @IBOutlet weak var btnAddCard: UIButton!
    
    /// UIButton to close the add card view
    @IBOutlet weak var btnCross: UIButton!
    
    /// UIView container for entering card details
    @IBOutlet weak var viewEnterCard: UIView!
    
    /// UIView overlay to make background transparent
    @IBOutlet weak var viewTransperent: UIView!
    
    /// UIView container for second add card view
    @IBOutlet weak var viewAddCard2: UIView!
    @IBOutlet weak var scrollViewAddCard: UIScrollView!
    
    /// UITextField for card number input
    @IBOutlet weak var txtCardNumber: UITextField!
    
    /// UITextField for expiry month input
    @IBOutlet weak var txtExpiryMonth: UITextField!
    
    /// UITextField for expiry year input
    @IBOutlet weak var txtExpiryYear: UITextField!
    
    /// UITextField for secure code input
    @IBOutlet weak var txtSecureCode: UITextField!
    
    /// UITextField for first name input
    @IBOutlet weak var txtFirstName: UITextField!
    
    /// UITextField for last name input
    @IBOutlet weak var txtLastName: UITextField!
    
    /// UIButton to confirm adding card
    @IBOutlet weak var btnEnterCard: UIButton!
    
    /// UIView container for thank you message
    @IBOutlet weak var viewThankYou: UIView!
    
    /// UIView container for second thank you view
    @IBOutlet weak var viewThankYou2: UIView!
    @IBOutlet weak var scrollViewThankYou: UIScrollView!
    
    /// UIButton to close thank you message
    @IBOutlet weak var btnThankYouCross: UIButton!
    
    /// UIButton to track the placed order
    @IBOutlet weak var btnTrackYourOrder: UIButton!
    
    /// UIButton to change delivery address
    @IBOutlet weak var btnChangeAddress: UIButton!
    
    /// UILabel to display subtotal amount
    @IBOutlet weak var lblSubTotal: UILabel!
    
    /// UILabel to display delivery cost
    @IBOutlet weak var lblDeliveryCost: UILabel!
    
    /// UILabel to display discount amount
    @IBOutlet weak var lblDiscount: UILabel!
    
    /// UILabel to display total amount
    @IBOutlet weak var lblTotal: UILabel!
    
    /// UILabel to display selected address
    @IBOutlet weak var lblAddress: UILabel!
    
    /// Stores the selected address text
    var addressText: String?
    
    /// Stores the selected payment model
    var objPaymentModel: PaymentModel?
    
    /// Subtotal amount
    var subtotal: Double = 0.0
    
    /// Delivery cost
    var deliveryCost: Double = 0.0
    
    /// Discount amount
    var discount: Double = 0.0
    
    /// Index of selected payment method
    var selectedPaymentIndex: Int? = nil
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Checkout",
                                    target: self,
                                    action: #selector(btnBackTapped))
        
        viewEnterCard.isHidden = true
        viewTransperent.isHidden = true
        viewThankYou.isHidden = true
        
        calculate()
        
        setViewTopCornerRadius(views: [viewEnterCard, scrollViewAddCard, viewAddCard2, viewThankYou, scrollViewThankYou, viewThankYou2])
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName, btnEnterCard, btnTrackYourOrder])
        
        setPadding.setPadding(left: 34, right: 34, textfield: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName])
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnSendOrder])
        
        tblCheckOutCard.backgroundColor = .clear
        tblCheckOutCard.showsVerticalScrollIndicator = false
        tblCheckOutCard.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblCheckOutCard.register(UINib(nibName: "AddCardTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCardTableViewCell")
        tblCheckOutCard.register(UINib(nibName: "UPITableViewCell", bundle: nil), forCellReuseIdentifier: "UPITableViewCell")
    }
    
    /// Called before the view appears on screen
    override func viewWillAppear(_ animated: Bool) {
        // Load from UserDefaults
        if let savedAddress = UserDefaults.standard.string(forKey: "lastSelectedAddress") {
            lblAddress.text = savedAddress
            addressText = savedAddress // if you also use addressText internally
        }
    }
    
    /// Calculates subtotal, delivery cost, discount and total
    func calculate() {
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblDiscount.text = "-$\(String(format: "%.2f", discount))"
        
        let total = subtotal + deliveryCost - discount
        lblTotal.text = "$\(String(format: "%.2f", total))"
    }
    
    /// Sets rounded corners for top of provided views
    func setViewTopCornerRadius(views: [UIView]) {
        for view in views {
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSize(width: 0, height: -2)
            view.layer.shadowRadius = 10
        }
    }
    
    /// Handles back button tap
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Opens AddressViewController for changing address
    @IBAction func btnChangeAddressClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Shows the add card view
    @IBAction func btnAddCardClick(_ sender: Any) {
        viewEnterCard.isHidden = false
        viewTransperent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewEnterCard.transform = .identity
        }
        setTabBar(hidden: true)
    }
    
    /// Closes the add card view
    @IBAction func btnCrossClick(_ sender: Any) {
        closeAddCardView()
    }
    
    /// Shows the thank you view after sending order
    @IBAction func btnSendOrderClick(_ sender: Any) {
        viewThankYou.isHidden = false
        viewTransperent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewThankYou.transform = .identity
        }
        setTabBar(hidden: true)
    }
    
    /// Closes the thank you view
    @IBAction func btnThankYouCrossClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewThankYou.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewThankYou.isHidden = true
            self.viewTransperent.isHidden = true
            self.setTabBar(hidden: false)
        }
    }
    
    /// Shows or hides the tab bar
    func setTabBar(hidden: Bool, animated: Bool = true) {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        
        let frame = tabBar.frame
        let offsetY = hidden ? UIScreen.main.bounds.height : UIScreen.main.bounds.height - frame.height
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                tabBar.frame.origin.y = offsetY
            }
        } else {
            tabBar.frame.origin.y = offsetY
        }
    }
    
    /// Shows the main tab bar controller
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController {
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 2
            }
        }
    }
    
    /// Adds a card to the list of saved cards
    func addCardData() {
        let obj = PaymentModel()
        obj.intCardNumber = Int(txtCardNumber.text ?? "")
        obj.intExpiryMonth = Int(txtExpiryMonth.text ?? "")
        obj.intExpiryYear = Int(txtExpiryYear.text ?? "")
        obj.intSecureCode = Int(txtSecureCode.text ?? "")
        obj.strFirstName = txtFirstName.text ?? ""
        obj.strLastName = txtLastName.text ?? ""
        app.arrCardData.append(obj)
        
        tblCheckOutCard.reloadData()
    }
    
    /// Closes the add card view with animation
    func closeAddCardView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEnterCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewEnterCard.isHidden = true
            self.viewTransperent.isHidden = true
            self.setTabBar(hidden: false)
        }
    }
    
    /// Returns to home tab bar controller
    @IBAction func btnBackToHomeClick(_ sender: Any) {
        showMainTabBar()
    }
    
    /// Placeholder for tracking order
    @IBAction func btnTrackYourOrderClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Handles adding a new card and closing the add card view
    @IBAction func btnEnterCardClick(_ sender: Any) {
        addCardData()
        tblCheckOutCard.reloadData()
        closeAddCardView()
        txtLastName.text = ""
        txtFirstName.text = ""
        txtCardNumber.text = ""
        txtExpiryMonth.text = ""
        txtExpiryYear.text = ""
        txtSecureCode.text = ""
    }
}
