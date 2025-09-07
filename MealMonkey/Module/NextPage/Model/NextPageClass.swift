import Foundation

/// Enum representing the type of button to display on a page.
enum ButtonText {
    
    /// Button indicates moving to the next page.
    case Next
    
    /// Button indicates finishing the flow.
    case Done
}

/// Class representing a single page in the onboarding flow.
class NextPageClass {
    
    /// Title of the page.
    var strTitle: String = ""
    
    /// Description or subtitle for the page.
    var strTitleDescription: String = ""
    
    /// Image asset name for the page.
    var strImage: String = ""
    
    /// Type of button for this page (Next or Done).
    var strButtonText: ButtonText = .Next
    
    /**
     Initializes a new NextPageClass object.
     
     - Parameters:
        - strTitle: The title of the page.
        - strTitleDescription: The description or subtitle of the page.
        - strImage: The image asset name for the page.
        - strButtonText: The button type, default is .Next.
     */
    init(strTitle: String, strTitleDescription: String, strImage: String, strButtonText: ButtonText = .Next){
        
        self.strTitle = strTitle
        self.strTitleDescription = strTitleDescription
        self.strImage = strImage
        self.strButtonText = strButtonText
    }
    
    /**
     Returns an array of NextPageClass objects representing all pages in the onboarding flow.
     
     - Returns: An array of NextPageClass with predefined title, description, image, and button type.
     */
    class func getNextPageData() -> [NextPageClass] {

        return [
            NextPageClass(
                strTitle: L("onboarding_title1"),
                strTitleDescription: L("onboarding_desc1"),
                strImage: "ic_image1",
                strButtonText: .Next
            ),
            NextPageClass(
                strTitle: L("onboarding_title2"),
                strTitleDescription: L("onboarding_desc2"),
                strImage: "ic_image2",
                strButtonText: .Next
            ),
            NextPageClass(
                strTitle: L("onboarding_title3"),
                strTitleDescription: L("onboarding_desc3"),
                strImage: "ic_image3",
                strButtonText: .Done
            )
        ]
    }
}
