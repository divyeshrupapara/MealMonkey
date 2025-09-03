import UIKit
import OTPFieldView

// MARK: - OTPViewController
class OTPViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var otpTextFieldView: OTPFieldView!   // New OTP Field View
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDidNotReceive: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack("Sign Up", target: self, action: #selector(btnBackTapped))
        
        setupOtpView()
        
        // Style buttons
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnNext])
    }

    // MARK: - OTP Setup
    func setupOtpView() {
        otpTextFieldView.fieldsCount = 4
        otpTextFieldView.fieldBorderWidth = 2
        otpTextFieldView.defaultBorderColor = .gray
        otpTextFieldView.filledBorderColor = .textFieldText
        otpTextFieldView.cursorColor = .textFieldText
        otpTextFieldView.displayType = .roundedCorner
        otpTextFieldView.fieldSize = 56
        otpTextFieldView.separatorSpace = 28
        otpTextFieldView.shouldAllowIntermediateEditing = false
        otpTextFieldView.delegate = self
        otpTextFieldView.initializeUI()
    }

    // MARK: - Button Actions
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.StoryBoard.UserStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.NewPasswordViewController) as? NewPasswordViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }

    @IBAction func btnDidNotReceiveClick(_ sender: Any) {
        UIAlertController.showAlert(
            title: Main.Alert.OTPViewController.OTPSent.title,
            message: Main.Alert.OTPViewController.OTPSent.message,
            viewController: self
        )
    }
}
