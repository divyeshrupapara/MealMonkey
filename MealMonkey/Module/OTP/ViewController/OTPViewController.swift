import UIKit

// MARK: - OTPViewController
class OTPViewController: UIViewController {

    // MARK: - IBOutlets
    
    /// TextField for first OTP digit
    @IBOutlet weak var txtFirstDigit: UITextField!
    
    /// TextField for second OTP digit
    @IBOutlet weak var txtSecondDigit: UITextField!
    
    /// TextField for third OTP digit
    @IBOutlet weak var txtThirdDigit: UITextField!
    
    /// TextField for fourth OTP digit
    @IBOutlet weak var txtFourthDigit: UITextField!
    
    /// Button to proceed to next screen
    @IBOutlet weak var btnNext: UIButton!
    
    /// Button to resend OTP
    @IBOutlet weak var btnDidNotReceive: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show navigation bar
        self.navigationController?.isNavigationBarHidden = false
        
        // Set left-aligned title with back button
        setLeftAlignedTitleWithBack("Sign Up", target: self, action: #selector(btnBackTapped))
        
        // Setup text fields
        let allviews = [txtFirstDigit!, txtSecondDigit!, txtThirdDigit!, txtFourthDigit!]
        for tf in allviews {
            tf.delegate = self
            tf.keyboardType = .numberPad
            tf.textAlignment = .center
        }
        
        // Apply corner radius styling
        viewStyle(cornerRadius: 12, borderWidth: 0, borderColor: .systemGray, textField: [txtFirstDigit, txtSecondDigit, txtThirdDigit, txtFourthDigit])
        viewStyle(cornerRadius: 28 , borderWidth: 0, borderColor: .systemGray, textField: [btnNext])
    }
    
    // MARK: - Button Actions
    
    /// Handles back button tap
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Handles next button tap, navigates to NewPasswordViewController
    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Handles "Did Not Receive OTP" button tap, shows confirmation alert
    @IBAction func btnDidNotReceiveClick(_ sender: Any) {
        UIAlertController.showAlert(title: "Success", message: "OTP Sent Successfully", viewController: self)
    }
}
