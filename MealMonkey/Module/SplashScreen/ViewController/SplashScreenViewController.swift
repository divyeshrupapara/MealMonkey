import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Splash Screen"
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        sleep(3)
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

