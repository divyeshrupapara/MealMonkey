import Foundation

class DessertsModel: NSObject {
    
    var imgDesserts: String?
    var strDessertsTitle: String?
    var floatRating: Float?
    var strText: String?
    
    init(imgDesserts: String? = nil, strDessertsTitle: String? = nil, floatRating: Float? = nil, strText: String? = nil) {
        self.imgDesserts = imgDesserts
        self.strDessertsTitle = strDessertsTitle
        self.floatRating = floatRating
        self.strText = strText
    }
    
    class func addDesserts()-> [DessertsModel] {
        return [
            DessertsModel(
                imgDesserts: "ic_desserts1", strDessertsTitle: "French Apple Pie",
                floatRating: 4.9,
                strText: "Minute by tuk tuk • Desserts"
            ),
            DessertsModel(
                imgDesserts: "ic_desserts2", strDessertsTitle: "Dark Chocolate Cake",
                floatRating: 4.9,
                strText: "Minute by tuk tuk • Desserts"
            ),
            DessertsModel(
                imgDesserts: "ic_desserts3", strDessertsTitle: "Street Shake",
                floatRating: 4.9,
                strText: "Minute by tuk tuk • Desserts"
            ),
            DessertsModel(
                imgDesserts: "ic_desserts4", strDessertsTitle: "Fudgy Chewy Brownies",
                floatRating: 4.9,
                strText: "Minute by tuk tuk • Desserts"
            ),
        ]
    }
}
