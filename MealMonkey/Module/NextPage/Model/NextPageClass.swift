import Foundation

enum ButtonText {
    
    case Next
    case Done
}

class NextPageClass {
    
    var strTitle: String = ""
    var strTitleDescription: String = ""
    var strImage: String = ""
    var strButtonText: ButtonText = .Next
    
    init(strTitle: String, strTitleDescription: String, strImage: String, strButtonText: ButtonText = .Next){
        
        self.strTitle = strTitle
        self.strTitleDescription = strTitleDescription
        self.strImage = strImage
        self.strButtonText = strButtonText
    }
    
    class func getNextPageData() -> [NextPageClass] {
        
        return [
            NextPageClass(
                strTitle: "Find Food You Love",
                strTitleDescription: "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep",
                strImage: "ic_image1",
                strButtonText: .Next
            ),
            NextPageClass(
                strTitle: "Fast Delivery",
                strTitleDescription: "Get your food delivered in under 30 minutes wherever you are",
                strImage: "ic_image2",
                strButtonText: .Next
            ),
            NextPageClass(
                strTitle: "Enjoy Your Meal",
                strTitleDescription: "Eat healthy, tasty and affordable meals at your convenience",
                strImage: "ic_image3",
                strButtonText: .Done
            )
        ]
    }
}
