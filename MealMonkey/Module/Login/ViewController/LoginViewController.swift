import UIKit

/// LoginViewController handles the login screen UI and login logic for the app.
class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var txtEmail: UITextField!       // Email input field
    @IBOutlet weak var txtPassword: UITextField!    // Password input field
    @IBOutlet weak var btnLogin: UIButton!          // Login button
    @IBOutlet weak var btnFacebook: UIButton!       // Facebook login button
    @IBOutlet weak var btnGoogle: UIButton!         // Google login button
    @IBOutlet weak var btnEye: UIButton!            // Toggle password visibility button
    
    // MARK: - Properties
    
    /// Tracks the password visibility state
    var isPasswordVisible: Bool = false
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Log in"
        self.navigationController?.isNavigationBarHidden = true
        
        // Apply UI styling
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtEmail, txtPassword, btnLogin, btnGoogle, btnFacebook])
        
        // Set padding for text fields
        setPadding.setPadding(left: 34, right: 34, textfield: [txtEmail])
        setPadding.setPadding(left: 34, right: 40, textfield: [txtPassword])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Validation Methods
    
    /// Validates email format using regex
    /// - Parameter email: Email string to validate
    /// - Returns: `true` if valid, `false` otherwise
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    /// Validates password format using regex
    /// - Parameter password: Password string to validate
    /// - Returns: `true` if valid, `false` otherwise
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    /// Validates login inputs and performs authentication against Core Data
    func validateLoginPassword() {
        guard let email = txtEmail.text, !email.isEmpty else {
            UIAlertController.showAlert(
                title: Main.Alert.LoginViewController.EmailMissing.title,
                message: Main.Alert.LoginViewController.EmailMissing.message,
                viewController: self
            )
            return
        }

        guard let password = txtPassword.text, !password.isEmpty else {
            UIAlertController.showAlert(
                title: Main.Alert.LoginViewController.PasswordMissing.title,
                message: Main.Alert.LoginViewController.PasswordMissing.message,
                viewController: self
            )
            return
        }

        // Fetch from Core Data
        if let user = CoreDataManager.shared.fetchUser(email: email, password: password) {
            print("Login Success! Welcome \(user.name ?? "")")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(user.email, forKey: "loggedInEmail")
            showMainTabBar()
        } else {
            UIAlertController.showAlert(
                title: Main.Alert.LoginViewController.LoginFailed.title,
                message: Main.Alert.LoginViewController.LoginFailed.message,
                viewController: self
            )
        }
    }
    
    // MARK: - IBActions
    
    /// Handles login button click
    @IBAction func btnLoginClick(_ sender: Any) {
        validateLoginPassword()
    }
    
    /// Shows main tab bar controller after successful login
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: Main.StoryBoard.HomeStoryboard, bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: Main.ViewController.MainTabViewController) as? UITabBarController {
            
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 2
            }
        }
    }
    
    /// Handles forget password button click
    @IBAction func btnForgetPasswordClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.UserStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.ForgetPasswordViewController) as? ForgetPasswordViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Handles sign up button click
    @IBAction func btnSignUpClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.UserStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.SignUpViewController) as? SignUpViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Toggles password visibility
    @IBAction func btnEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
