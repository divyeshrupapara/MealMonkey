import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtEmail:
            txtPassword.becomeFirstResponder()
        case txtPassword:
            textField.resignFirstResponder() // Dismiss keyboard
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
