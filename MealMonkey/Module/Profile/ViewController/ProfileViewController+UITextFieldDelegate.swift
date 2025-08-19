import Foundation
import UIKit

// MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    
    /// Handles the "Return" key on the keyboard to navigate between text fields
    /// - Parameter textField: The currently active text field
    /// - Returns: Bool indicating whether the text field should process the return key
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
