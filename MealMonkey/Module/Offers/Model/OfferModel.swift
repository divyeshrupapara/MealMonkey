import Foundation

/// Model class representing an offer in the application
class OfferModel: NSObject {
    
    /// Image name for the offer
    var imgOffer: String?
    
    /// Title of the offer
    var strOfferTitle: String?
    
    /// Rating of the offer
    var intRating: Float?
    
    /// Number of raters for the offer
    var intRater: Int?
    
    /// Name of the cafe associated with the offer
    var strCafeName: String?
    
    /// Type or variety of food offered
    var strFoodVariety: String?
    
    /**
     Initializer for the OfferModel.
     
     - Parameters:
        - imgOffer: Optional image name for the offer.
        - strOfferTitle: Optional title of the offer.
        - intRating: Optional rating value.
        - intRater: Optional number of raters.
        - strCafeName: Optional cafe name.
        - strFoodVariety: Optional food variety.
     */
    init(imgOffer: String? = nil, strOfferTitle: String? = nil, intRating: Float? = nil, intRater: Int? = nil, strCafeName: String? = nil, strFoodVariety: String? = nil) {
        self.imgOffer = imgOffer
        self.strOfferTitle = strOfferTitle
        self.intRating = intRating
        self.intRater = intRater
        self.strCafeName = strCafeName
        self.strFoodVariety = strFoodVariety
    }
    
    /**
     Returns an array of sample OfferModel objects.
     
     - Returns: Array of OfferModel instances.
     */
    class func addOffers() -> [OfferModel] {
        return [
            OfferModel(imgOffer: "ic_offer1",
                       strOfferTitle: "Café de Noires",
                       intRating: 4.9,
                       intRater: 124,
                       strCafeName: "Cafe",
                       strFoodVariety: "Western Food"),
            OfferModel(imgOffer: "ic_offer2",
                       strOfferTitle: "Isso",
                       intRating: 4.9,
                       intRater: 124,
                       strCafeName: "Cafe",
                       strFoodVariety: "Western Food"),
            OfferModel(imgOffer: "ic_offer3",
                       strOfferTitle: "Cafe Beans",
                       intRating: 4.9,
                       intRater: 124,
                       strCafeName: "Cafe",
                       strFoodVariety: "Western Food")
        ]
    }
}
