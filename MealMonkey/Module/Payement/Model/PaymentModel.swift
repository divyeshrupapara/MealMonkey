import Foundation

class PaymentModel: NSObject {
    var intCardNumber: Int?
    var intExpiryMonth: Int?
    var intExpiryYear: Int?
    var intSecureCode: Int?
    var strFirstName: String?
    var strLastName: String?
    
    init(intCardNumber: Int? = nil, intExpiryMonth: Int? = nil, intExpiryYear: Int? = nil, intSecureCode: Int? = nil, strFirstName: String? = nil, strLastName: String? = nil) {
        self.intCardNumber = intCardNumber
        self.intExpiryMonth = intExpiryMonth
        self.intExpiryYear = intExpiryYear
        self.intSecureCode = intSecureCode
        self.strFirstName = strFirstName
        self.strLastName = strLastName
    }
}
