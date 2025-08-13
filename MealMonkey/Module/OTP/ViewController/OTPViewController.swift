import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var txtFirstDigit: UITextField!
    @IBOutlet weak var txtSecondDigit: UITextField!
    @IBOutlet weak var txtThirdDigit: UITextField!
    @IBOutlet weak var txtFourthDigit: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDidNotReceive: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack("Sign Up", target: self, action: #selector(btnBackTapped))
        
        let allviews = [txtFirstDigit!, txtSecondDigit!, txtThirdDigit!, txtFourthDigit!]
        for tf in allviews {
                    tf.delegate = self
                    tf.keyboardType = .numberPad
                    tf.textAlignment = .center
                }
        
        viewStyle(cornerRadius: 12, borderWidth: 0, borderColor: .systemGray, textField: [txtFirstDigit, txtSecondDigit, txtThirdDigit, txtFourthDigit])
        viewStyle(cornerRadius: 28 , borderWidth: 0, borderColor: .systemGray, textField: [btnNext])
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnDidNotReceiveClick(_ sender: Any) {
        UIAlertController.showAlert(title: "Success", message: "OTP Sent Successfully", viewController: self)
    }
}
