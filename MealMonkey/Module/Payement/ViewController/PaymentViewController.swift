import UIKit

/// ViewController to manage Payment Details and saved cards
class PaymentViewController: UIViewController {
    
    /// Table view displaying saved cards
    @IBOutlet weak var tblCard: UITableView!
    
    /// Button to add a new card
    @IBOutlet weak var btnAddCard: UIButton!
    
    /// Button to close the "Add Card" view
    @IBOutlet weak var btnCross: UIButton!
    
    /// Text field for card number input
    @IBOutlet weak var txtCardNumber: UITextField!
    
    /// Text field for expiry month input
    @IBOutlet weak var txtExpiryMonth: UITextField!
    
    /// Text field for expiry year input
    @IBOutlet weak var txtExpiryYear: UITextField!
    
    /// Text field for CVV / secure code input
    @IBOutlet weak var txtSecureCode: UITextField!
    
    /// Text field for cardholder first name
    @IBOutlet weak var txtFirstName: UITextField!
    
    /// Text field for cardholder last name
    @IBOutlet weak var txtLastName: UITextField!
    
    /// Button to confirm card entry
    @IBOutlet weak var btnEnterCard: UIButton!
    
    /// Container view for entering card details
    @IBOutlet weak var viewEnterCard: UIView!
    
    /// Additional "Add Card" view
    @IBOutlet weak var viewAddCard2: UIView!
    @IBOutlet weak var scrollViewAddCard: UIScrollView!
    
    /// Transparent overlay behind "Add Card" view
    @IBOutlet weak var viewTransperent: UIView!
    
    var currentUser: User?
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide enter card and overlay views initially
        viewEnterCard.isHidden = true
        viewTransperent.isHidden = true
        
        // Apply corner radius and padding to input fields and buttons
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName, btnEnterCard])
        setPadding.setPadding(left: 34, right: 34, textfield: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName])
        
        addUpperCornerRadius(view: [viewAddCard2, viewEnterCard, scrollViewAddCard])
        
        // Setup navigation bar and cart button
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(btnBackTapped))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        // Style the "Add Card" button
        viewStyle(cornerRadius: btnAddCard.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddCard])
        
        // Setup table view for cards
        tblCard.showsVerticalScrollIndicator = false
        tblCard.register(UINib(nibName: Main.CellIdentifiers.CardTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.CardTableViewCell)
        tblCard.reloadData()
    }
    
    /// Called before the view appears
    override func viewWillAppear(_ animated: Bool) {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            self.currentUser = user
            let coreDataCards = CoreDataManager.shared.fetchCards(for: user)
            app.arrCardData = coreDataCards.map { card in
                PaymentModel(
                    intCardNumber: Int(card.cardNumber ?? ""),
                    intExpiryMonth: Int(card.expiryMonth),
                    intExpiryYear: Int(card.expiryYear),
                    intSecureCode: Int(card.secureCode),
                    strFirstName: card.firstName,
                    strLastName: card.lastName
                )
            }
        } else {
            app.arrCardData = []
        }
        updateEmptyStateView()
        tblCard.reloadData()
    }
    
    func addUpperCornerRadius(view: [UIView]) {
        // Style the add card view with rounded top corners and shadow
        for items in view {
            items.layer.cornerRadius = 20
            items.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            items.layer.shadowColor = UIColor.black.cgColor
            items.layer.shadowOpacity = 0.2
            items.layer.shadowOffset = CGSize(width: 0, height: -2)
            items.layer.shadowRadius = 10
        }
    }
    
    /// Adds the entered card data to the app's card array
    func addCardData() {
        guard let user = currentUser else { return }

        let obj = PaymentModel()
        obj.intCardNumber = Int(txtCardNumber.text ?? "")
        obj.intExpiryMonth = Int(txtExpiryMonth.text ?? "")
        obj.intExpiryYear = Int(txtExpiryYear.text ?? "")
        obj.intSecureCode = Int(txtSecureCode.text ?? "")
        obj.strFirstName = txtFirstName.text ?? ""
        obj.strLastName = txtLastName.text ?? ""

        // Save to Core Data
        CoreDataManager.shared.saveCard(for: user, model: obj)

        // Refresh local array
        let coreDataCards = CoreDataManager.shared.fetchCards(for: user)
        app.arrCardData = coreDataCards.map { card in
            PaymentModel(
                intCardNumber: Int(card.cardNumber ?? ""),
                intExpiryMonth: Int(card.expiryMonth),
                intExpiryYear: Int(card.expiryYear),
                intSecureCode: Int(card.secureCode),
                strFirstName: card.firstName,
                strLastName: card.lastName
            )
        }
        tblCard.reloadData()
    }
    
    func updateEmptyStateView() {
        if app.arrCardData.isEmpty {
            LottieAnimationHelper.showEmptyState(on: tblCard,
                                                 animationName: "Credit card",
                                                 message: "No Card")
        } else {
            LottieAnimationHelper.removeEmptyState(from: tblCard)
        }
    }
    
    /// Action to go back to the previous screen
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Action to open the Cart screen
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: Main.StoryBoard.MenuStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.CartViewController) as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Action triggered when "Enter Card" button is tapped
    @IBAction func btnEnterCard(_ sender: Any) {
        // Card number validation
        let cardNumber = txtCardNumber.text ?? ""
        if cardNumber.count != 16 {
            UIAlertController.showAlert(
                title: Main.Alert.CheckoutViewController.CardNumber.title,
                message: Main.Alert.CheckoutViewController.CardNumber.message,
                viewController: self
            )
            return
        }

        // Expiry month validation
        if let month = Int(txtExpiryMonth.text ?? ""), month < 1 || month > 12 {
            UIAlertController.showAlert(
                title: Main.Alert.CheckoutViewController.ExpiryMonth.title,
                message: Main.Alert.CheckoutViewController.ExpiryMonth.message,
                viewController: self
            )
            return
        }

        // Expiry year validation
        if (txtExpiryYear.text ?? "").count != 2 {
            UIAlertController.showAlert(
                title: Main.Alert.CheckoutViewController.ExpiryYear.title,
                message: Main.Alert.CheckoutViewController.ExpiryYear.message,
                viewController: self
            )
            return
        }

        // Secure code (CVV) validation
        if (txtSecureCode.text ?? "").count != 3 {
            UIAlertController.showAlert(
                title: Main.Alert.CheckoutViewController.CVV.title,
                message: Main.Alert.CheckoutViewController.CVV.message,
                viewController: self
            )
            return
        }
        
        // If all validations pass, add the card data
        addCardData()
        updateEmptyStateView()
        tblCard.reloadData()
        
        // Animate hiding of card entry view
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEnterCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewEnterCard.isHidden = true
            self.viewTransperent.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
        
        // Clear input fields
        txtLastName.text = ""
        txtFirstName.text = ""
        txtCardNumber.text = ""
        txtExpiryMonth.text = ""
        txtExpiryYear.text = ""
        txtSecureCode.text = ""
    }
    
    /// Action triggered when "Add Card" button is tapped
    @IBAction func btnAddCardClick(_ sender: Any) {
        viewEnterCard.isHidden = false
        viewTransperent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewEnterCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    /// Action triggered when "Cross" button is tapped to close "Add Card" view
    @IBAction func btnCrossClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEnterCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewEnterCard.isHidden = true
            self.viewTransperent.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
}
