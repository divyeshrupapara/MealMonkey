import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var btnSendOrder: UIButton!
    @IBOutlet weak var tblCheckOutCard: UITableView!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var viewEnterCard: UIView!
    @IBOutlet weak var viewTransperent: UIView!
    @IBOutlet weak var viewAddCard2: UIView!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtSecureCode: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnEnterCard: UIButton!
    @IBOutlet weak var viewThankYou: UIView!
    @IBOutlet weak var viewThankYou2: UIView!
    @IBOutlet weak var btnThankYouCross: UIButton!
    @IBOutlet weak var btnTrackYourOrder: UIButton!
    @IBOutlet weak var btnChangeAddress: UIButton!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var objPaymentModel: PaymentModel?
    var subtotal: Double = 0.0
    var deliveryCost: Double = 0.0
    var discount: Double = 0.0
    var selectedPaymentIndex: Int? = nil
    var selectedAddress: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Checkout",
                                    target: self,
                                    action: #selector(btnBackTapped))
        
        viewEnterCard.isHidden = true
        viewTransperent.isHidden = true
        viewThankYou.isHidden = true
    
        calculate()
        
        setViewTopCornerRadius(views: [viewAddCard2, viewThankYou2])
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName, btnEnterCard, btnTrackYourOrder])
        
        setPadding.setPadding(left: 34, right: 34, textfield: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName])
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnSendOrder])
        
        tblCheckOutCard.backgroundColor = .clear
        tblCheckOutCard.showsVerticalScrollIndicator = false
        tblCheckOutCard.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblCheckOutCard.register(UINib(nibName: "AddCardTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCardTableViewCell")
        tblCheckOutCard.register(UINib(nibName: "UPITableViewCell", bundle: nil), forCellReuseIdentifier: "UPITableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let address = selectedAddress {
            lblAddress.text = address
        }
    }
    
    func calculate() {
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblDiscount.text = "-$\(String(format: "%.2f", discount))"
        
        let total = subtotal + deliveryCost - discount
        lblTotal.text = "$\(String(format: "%.2f", total))"
    }
    
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
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChangeAddressClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController {
            selectedAddress = VC.bubble
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnAddCardClick(_ sender: Any) {
        viewEnterCard.isHidden = false
        viewTransperent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewEnterCard.transform = .identity
        }
        setTabBar(hidden: true)
    }
    
    @IBAction func btnCrossClick(_ sender: Any) {
        closeAddCardView()
    }
    
    @IBAction func btnSendOrderClick(_ sender: Any) {
        viewThankYou.isHidden = false
        viewTransperent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewThankYou.transform = .identity
        }
        setTabBar(hidden: true)
    }
    
    @IBAction func btnThankYouCrossClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewThankYou.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewThankYou.isHidden = true
            self.viewTransperent.isHidden = true
            self.setTabBar(hidden: false)
        }
    }
    
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
    
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController {
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
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
    
    func closeAddCardView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEnterCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewEnterCard.isHidden = true
            self.viewTransperent.isHidden = true
            self.setTabBar(hidden: false)
        }
    }
    
    @IBAction func btnBackToHomeClick(_ sender: Any) {
        showMainTabBar()
    }
    
    @IBAction func btnTrackYourOrderClick(_ sender: Any) {
    }
    
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
