import Foundation
import UIKit

extension OTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        if string.count > 1 {
            return false
        }
        
        if string.count == 1 {
            textField.text = string
            
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
