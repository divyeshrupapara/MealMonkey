import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnConfirmEye: UIButton!
    
    var isPasswordVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtName, txtEmail, txtMobileNo, txtAddress, txtPassword, txtConfirmPassword, btnSignUp])
        setPadding(textfield: [txtName, txtEmail, txtMobileNo, txtAddress, txtPassword, txtConfirmPassword])
    }
    
    @IBAction func btnBackToLoginClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if storyboard.instantiateViewController(withIdentifier: "LoginViewController") is LoginViewController{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setPadding(textfield: [UITextField]){
        
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @IBAction func btnEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnConfirmEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
