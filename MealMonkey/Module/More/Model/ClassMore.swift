import Foundation

/// Model class representing an item in the "More" menu
class ClassMore: NSObject {
    
    /// Title or name of the menu item
    var strMoreName: String = ""
    
    /// Image name for the menu icon
    var imgMenu: String = ""
    
    /// Tag or identifier for the menu item
    var intTag: Int = 0
    
    /// Initializes a new `ClassMore` instance
    /// - Parameters:
    ///   - strMoreName: Name of the menu item
    ///   - imgMenu: Image name for the menu item
    ///   - intTag: Tag or identifier
    init(strMoreName: String, imgMenu: String, intTag: Int) {
        self.strMoreName = strMoreName
        self.imgMenu = imgMenu
        self.intTag = intTag
    }
    
    /// Returns an array of default "More" menu items
    /// - Returns: Array of `ClassMore` objects
    class func addMore() -> [ClassMore] {
        return [
            ClassMore(strMoreName: L("more_payment_details"),
                      imgMenu: "ic_payment_details",
                      intTag: 0),
            ClassMore(strMoreName: L("more_my_orders"),
                      imgMenu: "ic_my_order",
                      intTag: 1),
            ClassMore(strMoreName: L("more_notifications"),
                      imgMenu: "ic_notification",
                      intTag: 2),
            ClassMore(strMoreName: L("more_inbox"),
                      imgMenu: "ic_inbox",
                      intTag: 3),
            ClassMore(strMoreName: L("more_about_us"),
                      imgMenu: "ic_aboutus",
                      intTag: 4),
            ClassMore(strMoreName: L("more_wishlist"),
                      imgMenu: "ic_wishlist",
                      intTag: 5),
            ClassMore(strMoreName: L("more_change_language"),
                      imgMenu: "ic_lang_change",
                      intTag: 6),
            ClassMore(strMoreName: L("more_change_theme"),
                      imgMenu: "ic_theme",
                      intTag: 7)
        ]
    }
}
