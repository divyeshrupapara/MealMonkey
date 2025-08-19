import Foundation

/// Model class representing a Payment Card
/// Conforms to `Codable` for easy encoding and decoding
class PaymentModel: Codable {
    
    /// Card number of the payment card
    var intCardNumber: Int?
    
    /// Expiry month of the card
    var intExpiryMonth: Int?
    
    /// Expiry year of the card
    var intExpiryYear: Int?
    
    /// Security code (CVV/CVC) of the card
    var intSecureCode: Int?
    
    /// Cardholder's first name
    var strFirstName: String?
    
    /// Cardholder's last name
    var strLastName: String?
    
    /// Initializes a new `PaymentModel` instance
    /// - Parameters:
    ///   - intCardNumber: Card number (optional)
    ///   - intExpiryMonth: Expiry month (optional)
    ///   - intExpiryYear: Expiry year (optional)
    ///   - intSecureCode: Security code (optional)
    ///   - strFirstName: Cardholder's first name (optional)
    ///   - strLastName: Cardholder's last name (optional)
    init(intCardNumber: Int? = nil, intExpiryMonth: Int? = nil, intExpiryYear: Int? = nil, intSecureCode: Int? = nil, strFirstName: String? = nil, strLastName: String? = nil) {
        self.intCardNumber = intCardNumber
        self.intExpiryMonth = intExpiryMonth
        self.intExpiryYear = intExpiryYear
        self.intSecureCode = intSecureCode
        self.strFirstName = strFirstName
        self.strLastName = strLastName
    }
}
