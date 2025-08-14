import Foundation
import UIKit

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtName:
            txtEmail.becomeFirstResponder()
        case txtEmail:
            txtMobileNo.becomeFirstResponder()
        case txtMobileNo:
            txtAddress.becomeFirstResponder()
        case txtAddress:
            txtPassword.becomeFirstResponder()
        case txtPassword:
            txtConfirmPassword.becomeFirstResponder()
        case txtConfirmPassword:
            textField.resignFirstResponder() // Dismiss keyboard
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
