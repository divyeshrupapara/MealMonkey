import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfiemPassword: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnConfirmEye: UIButton!
    
    var isPasswordVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack("New Password", target: self, action: #selector(btnBackTapped))
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtNewPassword, txtConfiemPassword, btnNext])
        MealMonkey.setPadding.setPadding(left: 34, right: 40, textfield: [txtNewPassword, txtConfiemPassword])
    }
    
    func validateNewPasswordConfirmPassword() {
          guard let newPassword = txtNewPassword.text, !newPassword.isEmpty else {
              UIAlertController.showAlert(title: "Error", message: "Please enter your new password.", viewController: self)
              return
          }
          
          guard isValidPassword(newPassword) else {
              UIAlertController.showAlert(
                  title: "Invalid Password",
                  message: "Password must have at least 8 characters, including uppercase, lowercase, a number, and a special symbol.",
                  viewController: self
              )
              return
          }
          
          guard let confirmPassword = txtConfiemPassword.text, !confirmPassword.isEmpty else {
              UIAlertController.showAlert(title: "Error", message: "Please confirm your password.", viewController: self)
              return
          }
          
          guard confirmPassword == newPassword else {
              UIAlertController.showAlert(title: "Error", message: "Passwords do not match.", viewController: self)
              return
          }
        
          let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
          if let VC = storyboard.instantiateViewController(withIdentifier: "NextPageViewController") as? NextPageViewController {
              self.navigationController?.pushViewController(VC, animated: true)
          }
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        validateNewPasswordConfirmPassword()
    }
    
    @IBAction func btnEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnConfirmEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfiemPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
