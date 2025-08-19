import Foundation

/// Model representing a dessert item
class DessertsModel: NSObject {
    
    /// Image name of the dessert
    var imgDesserts: String?
    
    /// Title of the dessert
    var strDessertsTitle: String?
    
    /// Rating of the dessert
    var floatRating: Float?
    
    /// Additional description text for the dessert
    var strText: String?
    
    /// Initializer for DessertModel
    /// - Parameters:
    ///   - imgDesserts: Image name
    ///   - strDessertsTitle: Dessert title
    ///   - floatRating: Dessert rating
    ///   - strText: Additional description
    init(imgDesserts: String? = nil, strDessertsTitle: String? = nil, floatRating: Float? = nil, strText: String? = nil) {
        self.imgDesserts = imgDesserts
        self.strDessertsTitle = strDessertsTitle
        self.floatRating = floatRating
        self.strText = strText
    }
    
    /// Returns a sample list of desserts
    /// - Returns: Array of `DessertsModel` objects
    class func addDesserts() -> [DessertsModel] {
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
