import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfiemPassword: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Password"
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(textfield: [txtNewPassword, txtConfiemPassword, btnNext])
        
        setPadding(textfield: [txtNewPassword, txtConfiemPassword])
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
    
    @IBAction func btnNextClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "NextPageViewController") as? NextPageViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
