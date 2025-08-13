import Foundation

class OfferModel: NSObject {
    
    var imgOffer: String?
    var strOfferTitle: String?
    var intRating: Float?
    var intRater: Int?
    var strCafeName: String?
    var strFoodVariety: String?
    
    init(imgOffer: String? = nil, strOfferTitle: String? = nil, intRating: Float? = nil, intRater: Int? = nil, strCafeName: String? = nil, strFoodVariety: String? = nil) {
        self.imgOffer = imgOffer
        self.strOfferTitle = strOfferTitle
        self.intRating = intRating
        self.intRater = intRater
        self.strCafeName = strCafeName
        self.strFoodVariety = strFoodVariety
    }
    
    class func addOffers()-> [OfferModel] {
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
