import Foundation
import UIKit

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtNewPassword:
            txtConfiemPassword.becomeFirstResponder()
        case txtConfiemPassword:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
