import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Forget Password"
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(textfield: [txtEmail, btnSend])
        
        setPadding(textfield: [txtEmail])
    }
    
    func viewStyle(textfield: [UIView]){
        
        for item in textfield {
            item.viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray)
        }
    }
    
    func setPadding(textfield: [UITextField]){
        
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @IBAction func btnSendClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
