import Foundation

/// Model representing various textual information such as About, Notifications, and Inbox items
class AboutModel {

    /// Main text content
    var strText: String?
    
    /// Time or timestamp associated with the content
    var strTimezone: String?
    
    /// Secondary text displayed on the right side (used for Inbox)
    var strRightSideText: String?
    
    /// Additional text content (used for Inbox)
    var strText2: String?

    /// Initializes a new instance of AboutModel
    ///
    /// - Parameters:
    ///   - strText: Main text content
    ///   - strTimezone: Time or timestamp
    ///   - strRightSideText: Right side text for inbox items
    ///   - strText2: Additional text for inbox items
    init(
        strText: String? = nil,
        strTimezone: String? = nil,
        strRightSideText: String? = nil,
        strText2: String? = nil
    ) {
        self.strText = strText
        self.strTimezone = strTimezone
        self.strRightSideText = strRightSideText
        self.strText2 = strText2
    }

    // MARK: - About Section Data

    /// Provides static About section data
    ///
    /// - Returns: Array of AboutModel representing app/company information
    class func addAboutData() -> [AboutModel] {
        return [
            AboutModel(strText: Main.addAboutMessage.strText1),
            AboutModel(strText: Main.addAboutMessage.strText2),
            AboutModel(strText: Main.addAboutMessage.strText3),
            AboutModel(strText: Main.addAboutMessage.strText4),
            AboutModel(strText: Main.addAboutMessage.strText5),
            AboutModel(strText: Main.addAboutMessage.strText6),
            AboutModel(strText: Main.addAboutMessage.strText7)
        ]
    }

    // MARK: - Notification Section Data

    /// Provides static Notification section data
    ///
    /// - Returns: Array of AboutModel representing notifications with timestamp
    class func addNotificationData() -> [AboutModel] {
        return [
            AboutModel(strText: Main.addNotiMessage.strText1, strTimezone: Main.addNotiMessage.strTimezone1),
            AboutModel(strText: Main.addNotiMessage.strText2, strTimezone: Main.addNotiMessage.strTimezone2),
            AboutModel(strText: Main.addNotiMessage.strText3, strTimezone: Main.addNotiMessage.strTimezone3),
            AboutModel(strText: Main.addNotiMessage.strText4, strTimezone: Main.addNotiMessage.strTimezone4),
            AboutModel(strText: Main.addNotiMessage.strText5, strTimezone: Main.addNotiMessage.strTimezone5),
            AboutModel(strText: Main.addNotiMessage.strText6, strTimezone: Main.addNotiMessage.strTimezone6),
            AboutModel(strText: Main.addNotiMessage.strText7, strTimezone: Main.addNotiMessage.strTimezone7),
            AboutModel(strText: Main.addNotiMessage.strText8, strTimezone: Main.addNotiMessage.strTimezone8),
            AboutModel(strText: Main.addNotiMessage.strText9, strTimezone: Main.addNotiMessage.strTimezone9),
            AboutModel(strText: Main.addNotiMessage.strText10, strTimezone: Main.addNotiMessage.strTimezone10),
            AboutModel(strText: Main.addNotiMessage.strText11, strTimezone: Main.addNotiMessage.strTimezone11),
            AboutModel(strText: Main.addNotiMessage.strText12, strTimezone: Main.addNotiMessage.strTimezone12),
            AboutModel(strText: Main.addNotiMessage.strText13, strTimezone: Main.addNotiMessage.strTimezone13),
            AboutModel(strText: Main.addNotiMessage.strText14, strTimezone: Main.addNotiMessage.strTimezone14),
            AboutModel(strText: Main.addNotiMessage.strText15, strTimezone: Main.addNotiMessage.strTimezone15)
        ]
    }

    // MARK: - Inbox Section Data

    /// Provides static Inbox section data
    ///
    /// - Returns: Array of AboutModel representing inbox messages with right-side text and additional details
    class func addInboxData() -> [AboutModel] {
        return [
            AboutModel(strText: Main.addInboxMessage.strText1, strRightSideText: Main.addInboxMessage.strRightSideText1, strText2: Main.addInboxMessage.strText21),
            AboutModel(strText: Main.addInboxMessage.strText2, strRightSideText: Main.addInboxMessage.strRightSideText2, strText2: Main.addInboxMessage.strText22),
            AboutModel(strText: Main.addInboxMessage.strText3, strRightSideText: Main.addInboxMessage.strRightSideText3, strText2: Main.addInboxMessage.strText23),
            AboutModel(strText: Main.addInboxMessage.strText4, strRightSideText: Main.addInboxMessage.strRightSideText4, strText2: Main.addInboxMessage.strText24),
            AboutModel(strText: Main.addInboxMessage.strText5, strRightSideText: Main.addInboxMessage.strRightSideText5, strText2: Main.addInboxMessage.strText25),
            AboutModel(strText: Main.addInboxMessage.strText6, strRightSideText: Main.addInboxMessage.strRightSideText6, strText2: Main.addInboxMessage.strText26),
            AboutModel(strText: Main.addInboxMessage.strText7, strRightSideText: Main.addInboxMessage.strRightSideText7, strText2: Main.addInboxMessage.strText27),
            AboutModel(strText: Main.addInboxMessage.strText8, strRightSideText: Main.addInboxMessage.strRightSideText8, strText2: Main.addInboxMessage.strText28),
            AboutModel(strText: Main.addInboxMessage.strText9, strRightSideText: Main.addInboxMessage.strRightSideText9, strText2: Main.addInboxMessage.strText29),
            AboutModel(strText: Main.addInboxMessage.strText10, strRightSideText: Main.addInboxMessage.strRightSideText10, strText2: Main.addInboxMessage.strText210),
            AboutModel(strText: Main.addInboxMessage.strText11, strRightSideText: Main.addInboxMessage.strRightSideText11, strText2: Main.addInboxMessage.strText211),
            AboutModel(strText: Main.addInboxMessage.strText12, strRightSideText: Main.addInboxMessage.strRightSideText12, strText2: Main.addInboxMessage.strText212),
            AboutModel(strText: Main.addInboxMessage.strText13, strRightSideText: Main.addInboxMessage.strRightSideText13, strText2: Main.addInboxMessage.strText213),
            AboutModel(strText: Main.addInboxMessage.strText14, strRightSideText: Main.addInboxMessage.strRightSideText14, strText2: Main.addInboxMessage.strText214),
            AboutModel(strText: Main.addInboxMessage.strText15, strRightSideText: Main.addInboxMessage.strRightSideText15, strText2: Main.addInboxMessage.strText215)
        ]
    }
}
