import Foundation
import UIKit

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtName:
            txtEmail.becomeFirstResponder()
        case txtEmail:
            txtMobileNo.becomeFirstResponder()
        case txtMobileNo:
            txtAddress.becomeFirstResponder()
        case txtAddress:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
