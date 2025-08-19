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
    
    /// Transparent overlay behind "Add Card" view
    @IBOutlet weak var viewTransperent: UIView!
    
    /// Label to show when no cards exist
    @IBOutlet weak var lblNoItem: UILabel!
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoItem.isHidden = true
        
        // Hide enter card and overlay views initially
        viewEnterCard.isHidden = true
        viewTransperent.isHidden = true
        
        // Style the add card view with rounded top corners and shadow
        viewAddCard2.layer.cornerRadius = 20
        viewAddCard2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard2.layer.shadowColor = UIColor.black.cgColor
        viewAddCard2.layer.shadowOpacity = 0.2
        viewAddCard2.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard2.layer.shadowRadius = 10
        
        // Apply corner radius and padding to input fields and buttons
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName, btnEnterCard])
        setPadding.setPadding(left: 34, right: 34, textfield: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName])
        
        // Setup navigation bar and cart button
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(btnBackTapped))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        // Style the "Add Card" button
        viewStyle(cornerRadius: btnAddCard.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddCard])
        
        // Setup table view for cards
        tblCard.showsVerticalScrollIndicator = false
        tblCard.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
        tblCard.reloadData()
    }
    
    /// Called before the view appears
    override func viewWillAppear(_ animated: Bool) {
        lblNoItem.isHidden = !app.arrCardData.isEmpty
        tblCard.reloadData()
    }
    
    /// Adds the entered card data to the app's card array
    func addCardData() {
        let obj = PaymentModel()
        obj.intCardNumber = Int(txtCardNumber.text ?? "")
        obj.intExpiryMonth = Int(txtExpiryMonth.text ?? "")
        obj.intExpiryYear = Int(txtExpiryYear.text ?? "")
        obj.intSecureCode = Int(txtSecureCode.text ?? "")
        obj.strFirstName = txtFirstName.text ?? ""
        obj.strLastName = txtLastName.text ?? ""
        app.arrCardData.append(obj)
        
        tblCard.reloadData()
    }
    
    /// Action to go back to the previous screen
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Action to open the Cart screen
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Action triggered when "Enter Card" button is tapped
    @IBAction func btnEnterCard(_ sender: Any) {
        // Card number validation
        let cardNumber = txtCardNumber.text ?? ""
        if cardNumber.count != 16 {
            UIAlertController.showAlert(
                title: "Invalid Card Number",
                message: "Card number must be exactly 16 digits.",
                viewController: self
            )
            return
        }
        
        // Expiry month validation
        if let month = Int(txtExpiryMonth.text ?? ""), month < 1 || month > 12 {
            UIAlertController.showAlert(
                title: "Invalid Expiry Month",
                message: "Please enter a valid month between 01 and 12.",
                viewController: self
            )
            return
        }
        
        // Expiry year validation
        if (txtExpiryYear.text ?? "").count != 2 {
            UIAlertController.showAlert(
                title: "Invalid Expiry Year",
                message: "Please enter a valid 2-digit year.",
                viewController: self
            )
            return
        }
        
        // Secure code (CVV) validation
        if (txtSecureCode.text ?? "").count != 3 {
            UIAlertController.showAlert(
                title: "Invalid CVV",
                message: "Secure code must be 3 digits.",
                viewController: self
            )
            return
        }
        
        // If all validations pass, add the card data
        addCardData()
        lblNoItem.isHidden = !app.arrCardData.isEmpty
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
