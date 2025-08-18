import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Delay without freezing UI
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateNext()
        }
    }
    
    private func navigateNext() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn"),
           let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            
            print("Auto-login as \(user.name ?? "")")
            
            // Go directly to MainTabBar
            let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        } else {
            // Go to Login
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
}
