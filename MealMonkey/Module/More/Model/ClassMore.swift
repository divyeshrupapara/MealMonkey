
import Foundation

class ClassMore: NSObject {
    
    var strMoreName: String = ""
    var imgMenu: String = ""
    var intTag: Int = 0
    
    init(strMoreName: String, imgMenu: String, intTag: Int) {
        self.strMoreName = strMoreName
        self.imgMenu = imgMenu
        self.intTag = intTag
    }
    
    class func addMore() -> [ClassMore] {
        
        return [
            ClassMore(strMoreName: "Payment Details",
                      imgMenu: "ic_payment_details",
                      intTag: 0),
            ClassMore(strMoreName: "My Orders",
                      imgMenu: "ic_my_order",
                      intTag: 1),
            ClassMore(strMoreName: "Notifications",
                      imgMenu: "ic_notification",
                      intTag: 2),
            ClassMore(strMoreName: "Inbox",
                      imgMenu: "ic_inbox",
                      intTag: 3),
            ClassMore(strMoreName: "About Us",
                      imgMenu: "ic_aboutus",
                      intTag: 4)
        ]
    }
}
