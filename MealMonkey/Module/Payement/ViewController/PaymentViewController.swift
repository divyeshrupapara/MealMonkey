import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var tblCard: UITableView!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtSecureCode: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnEnterCard: UIButton!
    @IBOutlet weak var viewEnterCard: UIView!
    @IBOutlet weak var viewAddCard2: UIView!
    @IBOutlet weak var viewTransperent: UIView!
    
    var arrCardData: [PaymentModel] = []
    var objPaymentModel: PaymentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewEnterCard.isHidden = true
        viewTransperent.isHidden = true
        viewAddCard2.layer.cornerRadius = 20
        viewAddCard2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard2.layer.shadowColor = UIColor.black.cgColor
        viewAddCard2.layer.shadowOpacity = 0.2
        viewAddCard2.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard2.layer.shadowRadius = 10
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName, btnEnterCard])
        
        setPadding.setPadding(left: 34, right: 34, textfield: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode, txtFirstName, txtLastName])
        
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(btnBackTapped))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        viewStyle(cornerRadius: btnAddCard.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddCard])
        
        tblCard.showsVerticalScrollIndicator = false
        tblCard.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
        tblCard.reloadData()
    }
    
    func addCardData() {
        let obj = PaymentModel()
        obj.intCardNumber = Int(txtCardNumber.text ?? "")
        obj.intExpiryMonth = Int(txtExpiryMonth.text ?? "")
        obj.intExpiryYear = Int(txtExpiryYear.text ?? "")
        obj.intSecureCode = Int(txtSecureCode.text ?? "")
        obj.strFirstName = txtFirstName.text ?? ""
        obj.strLastName = txtLastName.text ?? ""
        arrCardData.append(obj)
        
        tblCard.reloadData()
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnEnterCard(_ sender: Any) {
        addCardData()
        tblCard.reloadData()
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEnterCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewEnterCard.isHidden = true
            self.viewTransperent.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        }
        txtLastName.text = ""
        txtFirstName.text = ""
        txtCardNumber.text = ""
        txtExpiryMonth.text = ""
        txtExpiryYear.text = ""
        txtSecureCode.text = ""
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
}
