import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    
    var isPasswordVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Log in"
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtEmail, txtPassword, btnLogin, btnGoogle, btnFacebook])
        
        setPadding.setPadding(left: 34, right: 34, textfield: [txtEmail])
        setPadding.setPadding(left: 34, right: 40, textfield: [txtPassword])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    func validateLoginPassword() {
        guard let email = txtEmail.text, !email.isEmpty else {
            UIAlertController.showAlert(title: "Error", message: "Please enter your email address.", viewController: self)
            return
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            UIAlertController.showAlert(title: "Error", message: "Please enter your password.", viewController: self)
            return
        }
        
        // Fetch from Core Data
        if let user = CoreDataManager.shared.fetchUser(email: email, password: password) {
            print("Login Success! Welcome \(user.name ?? "")")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(user.email, forKey: "loggedInEmail")
            showMainTabBar()
        } else {
            UIAlertController.showAlert(title: "Login Failed", message: "Invalid email or password.", viewController: self)
        }
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        validateLoginPassword()
    }
    
    private func showMainTabBar() {
        
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController {
            
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 2
            }
        }
    }
    
    @IBAction func btnForgetPasswordClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController{
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnSignUpClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController{
            self.navigationController?.pushViewController(VC, animated: true)
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
}
