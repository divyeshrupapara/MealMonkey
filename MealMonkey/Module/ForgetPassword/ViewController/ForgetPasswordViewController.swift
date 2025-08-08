import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        self.navigationController?.isNavigationBarHidden = false
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtEmail, btnSend])
        
        setPadding(textfield: [txtEmail])
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @IBAction func btnSendClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
