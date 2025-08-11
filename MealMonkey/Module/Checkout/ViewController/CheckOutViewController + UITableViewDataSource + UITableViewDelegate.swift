import Foundation
import UIKit

extension CheckoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CashOnDeliveryTableViewCell", for: indexPath) as! CashOnDeliveryTableViewCell
            // configure COD cell here
            return cell
            
        case 1,2,3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardTableViewCell", for: indexPath) as! AddCardTableViewCell
            // configure Add Card cell here
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UPITableViewCell", for: indexPath) as! UPITableViewCell
            // configure UPI cell here
            return cell
            
        default:
            fatalError("Unexpected row index")
        }
    }
}

extension CheckoutViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Handle allowed characters
        if [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode].contains(textField) {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            guard allowedCharacters.isSuperset(of: characterSet) || string.isEmpty else { return false }
        } else if [txtFirstName, txtLastName].contains(textField) {
            let allowedLetters = CharacterSet.letters.union(.whitespaces)
            let characterSet = CharacterSet(charactersIn: string)
            guard allowedLetters.isSuperset(of: characterSet) || string.isEmpty else { return false }
        }
        
        // Current text after change
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Set max length rules
        var maxLength = Int.max
        switch textField {
        case txtCardNumber:
            maxLength = 16
        case txtExpiryMonth:
            maxLength = 2
        case txtExpiryYear:
            maxLength = 2
        case txtSecureCode:
            maxLength = 3
        default:
            break
        }
        
        return updatedText.count <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtCardNumber:
            txtExpiryMonth.becomeFirstResponder()
        case txtExpiryMonth:
            txtExpiryYear.becomeFirstResponder()
        case txtExpiryYear:
            txtSecureCode.becomeFirstResponder()
        case txtSecureCode:
            txtFirstName.becomeFirstResponder()
        case txtFirstName:
            txtLastName.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
