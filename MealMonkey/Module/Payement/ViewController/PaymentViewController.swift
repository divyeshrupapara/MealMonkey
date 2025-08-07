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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewEnterCard.isHidden = true
        
        viewAddCard2.layer.cornerRadius = 20
        viewAddCard2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard2.layer.shadowColor = UIColor.black.cgColor
        viewAddCard2.layer.shadowOpacity = 0.2
        viewAddCard2.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard2.layer.shadowRadius = 10
                
//                viewScroll.layer.cornerRadius = 20
//                viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//                viewScroll.layer.shadowColor = UIColor.black.cgColor
//                viewScroll.layer.shadowOpacity = 0.2
//                viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(btnBackTapped))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        viewStyle(cornerRadius: btnAddCard.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddCard])
        
        tblCard.showsVerticalScrollIndicator = false
        tblCard.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEnterCard(_ sender: Any) {
    }
    @IBAction func btnAddCardClick(_ sender: Any) {
        viewEnterCard.isHidden = false
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
            self.tabBarController?.tabBar.isHidden = false
        }
    }
}
