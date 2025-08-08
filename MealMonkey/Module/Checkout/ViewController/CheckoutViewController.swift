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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("My Order",
                                    target: self,
                                    action: #selector(btnBackTapped))
        
        viewEnterCard.isHidden = true
        viewTransperent.isHidden = true
        viewThankYou.isHidden = true
        
        viewAddCard2.layer.cornerRadius = 20
        viewAddCard2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard2.layer.shadowColor = UIColor.black.cgColor
        viewAddCard2.layer.shadowOpacity = 0.2
        viewAddCard2.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard2.layer.shadowRadius = 10
        
        viewThankYou2.layer.cornerRadius = 20
        viewThankYou2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewThankYou2.layer.shadowColor = UIColor.black.cgColor
        viewThankYou2.layer.shadowOpacity = 0.2
        viewThankYou2.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewThankYou2.layer.shadowRadius = 10
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName, btnEnterCard, btnTrackYourOrder])
        
        setPadding.setPadding(left: 34, right: 34, textfield: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName])
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnSendOrder])
        
        tblCheckOutCard.backgroundColor = .clear
        tblCheckOutCard.showsVerticalScrollIndicator = false
        tblCheckOutCard.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblCheckOutCard.register(UINib(nibName: "AddCardTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCardTableViewCell")
        tblCheckOutCard.register(UINib(nibName: "UPITableViewCell", bundle: nil), forCellReuseIdentifier: "UPITableViewCell")
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddCardClick(_ sender: Any) {
        viewEnterCard.isHidden = false
        viewTransperent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewEnterCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func btnCrossClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEnterCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewEnterCard.isHidden = true
            self.viewTransperent.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func btnSendOrderClick(_ sender: Any) {
        viewThankYou.isHidden = false
        viewTransperent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewThankYou.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func btnThankYouCrossClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewThankYou.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewThankYou.isHidden = true
            self.viewTransperent.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func btnTrackYourOrderClick(_ sender: Any) {
    }
    
    @IBAction func btnEnterCardClick(_ sender: Any) {
    }
}
