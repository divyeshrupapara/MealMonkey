import Foundation
import UIKit

/// UITableViewDataSource methods for PaymentViewController
extension PaymentViewController: UITableViewDataSource {
    
    /// Returns the number of rows in the table view based on saved cards
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.arrCardData.count
    }
    
    /// Configures each cell in the table view with card data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.CardTableViewCell, for: indexPath) as! CardTableViewCell
        
        // Configure the cell with the card model
        cell.cardConfigureCell(card: app.arrCardData[indexPath.row])
        
        // Closure to handle card deletion
        cell.deleteCard = {
            if let user = self.currentUser {
                let cardNumber = "\(app.arrCardData[indexPath.row].intCardNumber ?? 0)"
                CoreDataManager.shared.deleteCard(for: user, cardNumber: cardNumber)
                let coreDataCards = CoreDataManager.shared.fetchCards(for: user)
                app.arrCardData = coreDataCards.map { card in
                    let model = PaymentModel()
                    model.intCardNumber = Int(card.cardNumber ?? "")
                    model.intExpiryMonth = Int(card.expiryMonth)
                    model.intExpiryYear = Int(card.expiryYear)
                    model.intSecureCode = Int(card.secureCode)
                    model.strFirstName = card.firstName ?? ""
                    model.strLastName = card.lastName ?? ""
                    return model
                }
                self.updateEmptyStateView()
                self.tblCard.reloadData()
            }
        }
        return cell
    }
}

/// UITextFieldDelegate methods for PaymentViewController
extension PaymentViewController: UITextFieldDelegate {
    
    /// Controls character input and maximum length for text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Handle allowed characters for number fields
        if [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecureCode].contains(textField) {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            guard allowedCharacters.isSuperset(of: characterSet) || string.isEmpty else { return false }
        }
        // Handle allowed characters for name fields
        else if [txtFirstName, txtLastName].contains(textField) {
            let allowedLetters = CharacterSet.letters.union(.whitespaces)
            let characterSet = CharacterSet(charactersIn: string)
            guard allowedLetters.isSuperset(of: characterSet) || string.isEmpty else { return false }
        }
        
        // Determine the new text after applying the change
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Set maximum length rules based on text field type
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
        
        // Auto-focus to next field if maximum length reached
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
    
    /// Handles "Return" key behavior for text fields
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
