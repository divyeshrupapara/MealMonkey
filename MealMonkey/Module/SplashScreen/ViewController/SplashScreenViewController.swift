import UIKit

class SplashScreenViewController: UIViewController {

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide navigation bar on splash screen
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Ensure navigation bar stays hidden when view appears
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Wait for 3 seconds without blocking UI
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateNext()
        }
    }
    
    // MARK: - Navigation
    
    /// Determines the next screen based on login status
    private func navigateNext() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn"),
           let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            
            // Auto-login detected
            print("Auto-login as \(user.name ?? "")")
            
            // Navigate to MainTabViewController
            let storyboard = UIStoryboard(name: Main.StoryBoard.HomeStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.MainTabViewController) as? UITabBarController {
                VC.selectedIndex = 2
                self.navigationController?.pushViewController(VC, animated: true)
            }
        } else {
            // Not logged in; navigate to Login screen
            let storyboard = UIStoryboard(name: Main.StoryBoard.UserStoryboard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.LoginViewController) as? LoginViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
}
