import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack("Forgot Password", target: self, action: #selector(btnBackTapped))
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtEmail, btnSend])
        
        setPadding(textfield: [txtEmail])
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @IBAction func btnSendClick(_ sender: Any) {
        
        let email = txtEmail.text ?? ""
        
        if isValidEmail(txtEmail.text ?? "") {
            showAlert(title: "Success", message: "OTP Sent Successfully", viewController: self)
        } else if email.isEmpty {
            UIAlertController.showAlert(title: "Email Missing", message: "Please enter your Email.", viewController: self)
        }
    }
    
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }))
        
        viewController.present(alert, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}
