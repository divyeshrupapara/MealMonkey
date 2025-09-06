import UIKit

// MARK: - Forget Password View Controller
class ForgetPasswordViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show navigation bar with back button
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack("Forgot Password", target: self, action: #selector(btnBackTapped))
        
        // Apply UI styling
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtEmail, btnSend])
        
        // Set padding for text fields
        setPadding(textfield: [txtEmail])
    }
    
    // MARK: - Navigation
    
    /// Handle back button tap
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    /// Apply left and right padding to text fields
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    /// Validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    /// Show alert and navigate to OTP screen on success
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let storyboard = UIStoryboard(name: Main.StoryBoard.UserStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.OTPViewController) as? OTPViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }))
        viewController.present(alert, animated: true)
    }
    
    // MARK: - IBActions
    
    /// Handle Send button tap
    @IBAction func btnSendClick(_ sender: Any) {
        let email = txtEmail.text ?? ""
        
        if isValidEmail(email) {
            showAlert(title: Main.Alert.ForgetPasswordViewController.Success.title, message: Main.Alert.ForgetPasswordViewController.Success.message, viewController: self)
        } else if email.isEmpty {
            UIAlertController.showAlert(title: Main.Alert.ForgetPasswordViewController.EmailMissing.title, message: Main.Alert.ForgetPasswordViewController.EmailMissing.message, viewController: self)
        }
    }
}
