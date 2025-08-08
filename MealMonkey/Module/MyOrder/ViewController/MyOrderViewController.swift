import UIKit

class MyOrderViewController: UIViewController {
    
    @IBOutlet weak var btnCheckOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("My Order",
                                    target: self,
                                    action: #selector(btnBackTapped))
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnCheckOut])
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCheckOutClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
