import Foundation
import UIKit

/// UITextFieldDelegate methods for handling keyboard return actions
extension NewPasswordViewController: UITextFieldDelegate {
    
    /// Handles Return key press for New Password and Confirm Password fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtNewPassword:
            // Move focus to Confirm Password field
            txtConfiemPassword.becomeFirstResponder()
        case txtConfiemPassword:
            // Dismiss keyboard
            textField.resignFirstResponder()
        default:
            // Dismiss keyboard for any other text fields (if added in future)
            textField.resignFirstResponder()
        }
        return true
    }
}
