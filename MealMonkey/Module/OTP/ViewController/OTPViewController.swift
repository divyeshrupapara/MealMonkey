import UIKit
import OTPFieldView

// MARK: - OTPViewController
class OTPViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblOTPHeading: UILabel!
    @IBOutlet weak var otpTextFieldView: OTPFieldView!   // New OTP Field View
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDidNotReceive: UIButton!

    let theme = ThemeManager.shared.currentTheme

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack(L("otp_screen_title"), target: self, action: #selector(btnBackTapped))

        lblOTPHeading.text = L("otp_lblOTPHeading")
        lblSubTitle.text = L("otp_lblSubTitle")

        btnNext.setTitle(L("otp_btnNext"), for: .normal)
        let part1 = NSAttributedString(
            string: L("otp_btnDidNotReceive_part1"),
            attributes: [
                .foregroundColor: theme.SecondaryFontColor,
                .font: UIFont(name: "Helvetica", size: 14) ?? UIFont.systemFont(ofSize: 14)
            ]
        )

        let part2 = NSAttributedString(
            string: L("otp_btnDidNotReceive_part2"),
            attributes: [
                .foregroundColor: theme.MainColor,
                .font: UIFont(name: "Helvetica", size: 14) ?? UIFont.systemFont(ofSize: 14)
            ]
        )

        // Combine the two parts
        let combinedText = NSMutableAttributedString()
        combinedText.append(part1)
        combinedText.append(part2)

        // Set the combined attributed title
        btnDidNotReceive.setAttributedTitle(combinedText, for: .normal)
        setupOtpView()
        
        // Style buttons
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnNext])
        
        applyTheme()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: .themeChanged,
            object: nil
        )
    }
    
    @objc func applyTheme() {
        viewMain.backgroundColor = theme.AppBackgroundColor
        otpTextFieldView.backgroundColor = theme.AppBackgroundColor
        self.view.backgroundColor = theme.AppBackgroundColor
        lblOTPHeading.textColor = theme.PrimaryFontColor
        lblSubTitle.textColor = theme.SecondaryFontColor
        btnNext.setTitleColor(theme.AppBackgroundColor, for: .normal)
        btnNext.backgroundColor = theme.MainColor
    }

    // MARK: - OTP Setup
    func setupOtpView() {
        otpTextFieldView.fieldsCount = 4
        otpTextFieldView.fieldBorderWidth = 2
        otpTextFieldView.defaultBorderColor = theme.PlaceholderColor
        otpTextFieldView.filledBorderColor = theme.MainColor
        otpTextFieldView.cursorColor = theme.SecondaryFontColor
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
