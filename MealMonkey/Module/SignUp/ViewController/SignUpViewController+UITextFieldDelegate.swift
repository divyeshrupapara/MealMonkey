import Foundation
import UIKit

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    /// Handles the Return/Next button on keyboard to move to the next text field in the form
    /// - Parameter textField: The current UITextField
    /// - Returns: Bool indicating whether the action should be processed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtName:
            txtEmail.becomeFirstResponder()       // Move focus to Email field
        case txtEmail:
            txtMobileNo.becomeFirstResponder()    // Move focus to Mobile Number field
        case txtMobileNo:
            txtAddress.becomeFirstResponder()     // Move focus to Address field
        case txtAddress:
            txtPassword.becomeFirstResponder()    // Move focus to Password field
        case txtPassword:
            txtConfirmPassword.becomeFirstResponder() // Move focus to Confirm Password field
        case txtConfirmPassword:
            textField.resignFirstResponder()      // Dismiss keyboard
        default:
            textField.resignFirstResponder()      // Fallback to dismiss keyboard
        }
        return true
    }
}
