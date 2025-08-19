import Foundation
import UIKit

/// UITextFieldDelegate methods for LoginViewController to handle keyboard return actions
extension LoginViewController: UITextFieldDelegate {
    
    /// Handles the Return key press for text fields
    /// - Parameter textField: The UITextField currently being edited
    /// - Returns: `true` to allow the default behavior
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtEmail:
            // Move focus to the password field when Return is pressed on email
            txtPassword.becomeFirstResponder()
        case txtPassword:
            // Dismiss keyboard when Return is pressed on password field
            textField.resignFirstResponder()
        default:
            // Dismiss keyboard for any other text field
            textField.resignFirstResponder()
        }
        return true
    }
}
