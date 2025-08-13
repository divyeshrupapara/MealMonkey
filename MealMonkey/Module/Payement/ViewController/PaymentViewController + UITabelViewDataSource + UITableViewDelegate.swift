import Foundation
import UIKit

extension PaymentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        
        cell.cardConfigureCell(card: arrCardData[indexPath.row])
        
        cell.deleteCard = {
            self.arrCardData.remove(at: indexPath.row)
            self.tblCard.reloadData()
        }
        return cell
    }
}

extension PaymentViewController: UITextFieldDelegate {
    
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
