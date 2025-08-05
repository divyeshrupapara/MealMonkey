import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Log in"
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(textfield: [txtEmail, txtPassword, btnLogin, btnGoogle, btnFacebook])
        
        setPadding(textfield: [txtEmail, txtPassword])
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
        showMainTabBar()
    }
    
    private func showMainTabBar() {
        
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController {
            
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
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
}
