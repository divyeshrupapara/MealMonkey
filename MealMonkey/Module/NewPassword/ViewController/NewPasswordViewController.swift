import UIKit

/// ViewController to handle setting a new password and confirming it
class NewPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfiemPassword: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnConfirmEye: UIButton!
    
    // MARK: - Properties
    /// Tracks the visibility of password fields
    var isPasswordVisible: Bool = false
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack("New Password", target: self, action: #selector(btnBackTapped))
        
        // Apply styling and padding
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtNewPassword, txtConfiemPassword, btnNext])
        setPadding.setPadding(left: 34, right: 40, textfield: [txtNewPassword, txtConfiemPassword])
    }
    
    // MARK: - Validation
    /// Validates the new password and confirm password fields
    func validateNewPasswordConfirmPassword() {
        guard let newPassword = txtNewPassword.text, !newPassword.isEmpty else {
            UIAlertController.showAlert(
                title: Main.Alert.NewPasswordViewController.NewPasswordMissing.title,
                message: Main.Alert.NewPasswordViewController.NewPasswordMissing.message,
                viewController: self
            )
            return
        }

        guard isValidPassword(newPassword) else {
            UIAlertController.showAlert(
                title: Main.Alert.NewPasswordViewController.InvalidPassword.title,
                message: Main.Alert.NewPasswordViewController.InvalidPassword.message,
                viewController: self
            )
            return
        }

        guard let confirmPassword = txtConfiemPassword.text, !confirmPassword.isEmpty else {
            UIAlertController.showAlert(
                title: Main.Alert.NewPasswordViewController.ConfirmPasswordMissing.title,
                message: Main.Alert.NewPasswordViewController.ConfirmPasswordMissing.message,
                viewController: self
            )
            return
        }

        guard confirmPassword == newPassword else {
            UIAlertController.showAlert(
                title: Main.Alert.NewPasswordViewController.PasswordMismatch.title,
                message: Main.Alert.NewPasswordViewController.PasswordMismatch.message,
                viewController: self
            )
            return
        }
        
        // Navigate to next page if validation succeeds
        let storyboard = UIStoryboard(name: Main.StoryBoard.UserStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.NextPageViewController) as? NextPageViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Checks if a password is valid according to rules (uppercase, lowercase, number, special character, min 8 chars)
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    // MARK: - Actions
    /// Handles back button tap
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Triggered when Next button is tapped
    @IBAction func btnNextClick(_ sender: Any) {
        validateNewPasswordConfirmPassword()
    }
    
    /// Toggles visibility of New Password field
    @IBAction func btnEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Toggles visibility of Confirm Password field
    @IBAction func btnConfirmEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfiemPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
