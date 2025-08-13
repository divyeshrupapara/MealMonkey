import Foundation
import UIKit

extension CheckoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaymentIndex = indexPath.row
        tableView.reloadData()
    }
}

extension CheckoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + app.arrCardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CashOnDeliveryTableViewCell", for: indexPath) as! CashOnDeliveryTableViewCell
            let isSelected = (selectedPaymentIndex == indexPath.row)
            let imageName = isSelected ? "ic_circle_fill" : "ic_circle"
            cell.btnSelectCOD.setImage(UIImage(named: imageName), for: .normal)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UPITableViewCell", for: indexPath) as! UPITableViewCell
            let isSelected = (selectedPaymentIndex == indexPath.row)
            let imageName = isSelected ? "ic_circle_fill" : "ic_circle"
            cell.btnSelectUPI.setImage(UIImage(named: imageName), for: .normal)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardTableViewCell", for: indexPath) as! AddCardTableViewCell
            let cardIndex = indexPath.row - 2
            if cardIndex < app.arrCardData.count {
                cell.CheckoutConfigureCell(card: app.arrCardData[cardIndex])
            }
            let isSelected = (selectedPaymentIndex == indexPath.row)
            let imageName = isSelected ? "ic_circle_fill" : "ic_circle"
            cell.btnSelectCard.setImage(UIImage(named: imageName), for: .normal)
            return cell
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
        case txtCardNumber: maxLength = 16
        case txtExpiryMonth: maxLength = 2
        case txtExpiryYear: maxLength = 2
        case txtSecureCode: maxLength = 3
        default: break
        }
        
        if updatedText.count == maxLength {
            DispatchQueue.main.async { [weak self] in
                switch textField {
                case self?.txtSecureCode:
                    self?.txtFirstName.becomeFirstResponder()
                default:
                    break
                }
            }
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
