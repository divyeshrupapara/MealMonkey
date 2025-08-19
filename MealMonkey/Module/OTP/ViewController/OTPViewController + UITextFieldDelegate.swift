import Foundation
import UIKit

// MARK: - UITextFieldDelegate for OTP Handling
extension OTPViewController: UITextFieldDelegate {
    
    /// Handles character input for OTP text fields
    /// - Parameters:
    ///   - textField: The text field currently being edited
    ///   - range: The range of characters to be replaced
    ///   - string: The replacement string
    /// - Returns: Bool indicating whether the change should be allowed
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Only allow numeric input
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        // Prevent pasting multiple characters
        if string.count > 1 {
            return false
        }
        
        if string.count == 1 { // Input character
            textField.text = string
            
            // Move focus to next text field
            switch textField {
            case txtFirstDigit:
                txtSecondDigit.becomeFirstResponder()
            case txtSecondDigit:
                txtThirdDigit.becomeFirstResponder()
            case txtThirdDigit:
                txtFourthDigit.becomeFirstResponder()
            case txtFourthDigit:
                txtFourthDigit.resignFirstResponder()
            default:
                break
            }
            return false
            
        } else if string.isEmpty { // Backspace pressed
            
            // Move focus to previous text field
            switch textField {
            case txtFourthDigit:
                txtThirdDigit.becomeFirstResponder()
            case txtThirdDigit:
                txtSecondDigit.becomeFirstResponder()
            case txtSecondDigit:
                txtFirstDigit.becomeFirstResponder()
            default:
                break
            }
            
            textField.text = ""
            return false
        }
        
        return true
    }
}
