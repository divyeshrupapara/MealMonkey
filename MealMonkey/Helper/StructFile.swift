import Foundation

struct Main {
    struct CellIdentifiers {
        static let AboutUsTableViewCell = "AboutUsTableViewCell"
        static let CartTableViewCell = "CartTableViewCell"
        static let AddCardTableViewCell = "AddCardTableViewCell"
        static let CashOnDeliveryTableViewCell = "CashOnDeliveryTableViewCell"
        static let UPITableViewCell = "UPITableViewCell"
        static let DessertsTableViewCell = "DessertsTableViewCell"
        static let HomeTableViewCell = "HomeTableViewCell"
        static let HomeCategoryCollectionViewCell = "HomeCategoryCollectionViewCell"
        static let PopularCollectionViewCell = "PopularCollectionViewCell"
        static let MostPopularCollectionViewCell = "MostPopularCollectionViewCell"
        static let RecentItemsCollectionViewCell = "RecentItemsCollectionViewCell"
        static let MenuTableViewCell = "MenuTableViewCell"
        static let MoreTableViewCell = "MoreTableViewCell"
        static let MyOrderTableViewCell = "MyOrderTableViewCell"
        static let CollectionViewCellNextPageCollectionViewCell = "CollectionViewCellNextPageCollectionViewCell"
        static let OffersTableViewCell = "OffersTableViewCell"
        static let OrderListTableViewCell = "OrderListTableViewCell"
        static let CardTableViewCell = "CardTableViewCell"
    }

    struct Image {
        static let ic_all = "ic_all"
        static let ic_punjabi = "ic_punjabi"
        static let ic_chinese = "ic_chinese"
        static let ic_gujarati = "ic_gujarati"
        static let ic_southindian = "ic_southindian"
        static let ic_westernfood = "ic_westernfood"
        static let ic_current_position = "ic_current_position"
    }
    
    struct Alert {
        struct CheckoutViewController {
            struct CardNumber {
                static let title = "Invalid Card Number"
                static let message = "Card number must be exactly 16 digits."
            }
            struct ExpiryMonth {
                static let title = "Invalid Expiry Month"
                static let message = "Please enter a valid month between 01 and 12."
            }
            struct ExpiryYear {
                static let title = "Invalid Expiry Year"
                static let message = "Please enter a valid 2-digit year."
            }
            struct CheckExpiryMonthYear {
                static let title = "Invalid Expiry Date"
                static let message = "Your card has already expired."
            }
            struct CVV {
                static let title = "Invalid CVV"
                static let message = "Secure code must be 3 digits."
            }
            struct FirstName {
                static let title = "Missing First Name"
                static let message = "Please enter your first name."
            }
            struct LastName {
                static let title = "Missing Last Name"
                static let message = "Please enter your last name."
            }
        }
        
        struct ForgetPasswordViewController {
            struct Success {
                static let title = "Success"
                static let message = "OTP Sent Successfully"
            }
            struct EmailMissing {
                static let title = "Email Missing"
                static let message = "Please enter your Email."
            }
        }
        
        struct LoginViewController {
            struct EmailMissing {
                static let title = "Error"
                static let message = "Please enter your email address."
            }
            struct PasswordMissing {
                static let title = "Error"
                static let message = "Please enter your password."
            }
            struct LoginFailed {
                static let title = "Login Failed"
                static let message = "Invalid email or password."
            }
        }
        
        struct NewPasswordViewController {
            struct NewPasswordMissing {
                static let title = "Error"
                static let message = "Please enter your new password."
            }
            struct InvalidPassword {
                static let title = "Invalid Password"
                static let message = "Password must have at least 8 characters, including uppercase, lowercase, a number, and a special symbol."
            }
            struct ConfirmPasswordMissing {
                static let title = "Error"
                static let message = "Please confirm your password."
            }
            struct PasswordMismatch {
                static let title = "Error"
                static let message = "Passwords do not match."
            }
        }
        
        struct OTPViewController {
            struct OTPSent {
                static let title = "Success"
                static let message = "OTP Sent Successfully"
            }
        }
        
        struct ProfileViewController {
            struct EmailMissing {
                static let title = "Error"
                static let message = "Email cannot be empty."
            }
            struct EmailExists {
                static let title = "Email Exists"
                static let message = "This email is already registered with another account."
            }
            struct UpdateSuccess {
                static let title = "Success"
                static let message = "Profile updated successfully!"
            }
        }
        
        struct SignUpViewController {
            struct MissingAllFields {
                static let title = "Missing Info"
                static let message = "Please enter all fields."
            }
            struct MissingNameEmail {
                static let title = "Missing Info"
                static let message = "Please enter your name and email."
            }
            struct MissingEmailPassword {
                static let title = "Missing Info"
                static let message = "Please enter your email and password."
            }
            struct MissingPasswordConfirm {
                static let title = "Missing Info"
                static let message = "Please enter your password and confirm password."
            }
            struct NameMissing {
                static let title = "Name Missing"
                static let message = "Please enter your name."
            }
            struct EmailMissing {
                static let title = "Email Missing"
                static let message = "Please enter your email."
            }
            struct MobileMissing {
                static let title = "Mobile Missing"
                static let message = "Please enter your mobile number."
            }
            struct CheckMobileDigit {
                static let title = "Invalid Mobile Number"
                static let message = "Mobile number must be exactly 10 digits."
            }
            struct AddressMissing {
                static let title = "Address Missing"
                static let message = "Please enter your address."
            }
            struct PasswordMissing {
                static let title = "Password Missing"
                static let message = "Please enter your password."
            }
            struct ConfirmPasswordMissing {
                static let title = "Confirm Password Missing"
                static let message = "Please confirm your password."
            }
            struct InvalidEmail {
                static let title = "Invalid Email"
                static let message = "Please enter a valid email address."
            }
            struct InvalidPassword {
                static let title = "Invalid Password"
                static let message = "Password must be at least 8 characters long and include uppercase, lowercase, number, and special character."
            }
            struct PasswordMismatch {
                static let title = "Passwords Do Not Match"
                static let message = "The password and confirm password must be the same."
            }
            struct EmailExists {
                static let title = "Email Exists"
                static let message = "This email is already registered. Please use another email."
            }
        }
    }

    struct StoryBoard {
        static let HomeStoryboard = "HomeStoryboard"
        static let Main = "Main"
        static let MenuStoryboard = "MenuStoryboard"
        static let MoreStoryboard = "MoreStoryboard"
        static let ProductStoryBoard = "ProductStoryBoard"
        static let UserStoryboard = "UserStoryboard"
    }
    
    struct ViewController {
        static let AboutUsViewController = "AboutUsViewController"
        static let AddressViewController = "AddressViewController"
        static let CartViewController = "CartViewController"
        static let CheckoutViewController = "CheckoutViewController"
        static let DessertsViewController = "DessertsViewController"
        static let FoodDetailViewController = "FoodDetailViewController"
        static let ForgetPasswordViewController = "ForgetPasswordViewController"
        static let HomeViewController = "HomeViewController"
        static let LoginViewController = "LoginViewController"
        static let MenuViewController = "MenuViewController"
        static let MoreViewController = "MoreViewController"
        static let MyOrderViewController = "MyOrderViewController"
        static let NewPasswordViewController = "NewPasswordViewController"
        static let NextPageViewController = "NextPageViewController"
        static let OffersViewController = "OffersViewController"
        static let OrderListViewController = "OrderListViewController"
        static let OTPViewController = "OTPViewController"
        static let PaymentViewController = "PaymentViewController"
        static let ProfileViewController = "ProfileViewController"
        static let SignUpViewController = "SignUpViewController"
        static let SplashScreenViewController = "SplashScreenViewController"
        static let WishListViewController = "WishListViewController"
        static let MainTabViewController = "MainTabViewController"
    }
    
    struct AddAboutMessage {
        static var strText1: String { L("about_message_text1") }
        static var strText2: String { L("about_message_text2") }
        static var strText3: String { L("about_message_text3") }
        static var strText4: String { L("about_message_text4") }
        static var strText5: String { L("about_message_text5") }
        static var strText6: String { L("about_message_text6") }
        static var strText7: String { L("about_message_text7") }
    }
    
    struct addNotiMessage {
        static var strText1: String { L("noti_text1") }
        static var strText2: String { L("noti_text2") }
        static var strText3: String { L("noti_text3") }
        static var strText4: String { L("noti_text4") }
        static var strText5: String { L("noti_text5") }
        static var strText6: String { L("noti_text6") }
        static var strText7: String { L("noti_text7") }
        static var strText8: String { L("noti_text8") }
        static var strText9: String { L("noti_text9") }
        static var strText10: String { L("noti_text10") }
        static var strText11: String { L("noti_text11") }
        static var strText12: String { L("noti_text12") }
        static var strText13: String { L("noti_text13") }
        static var strText14: String { L("noti_text14") }
        static var strText15: String { L("noti_text15") }

        static var strTimezone1: String { L("noti_time1") }
        static var strTimezone2: String { L("noti_time2") }
        static var strTimezone3: String { L("noti_time3") }
        static var strTimezone4: String { L("noti_time4") }
        static var strTimezone5: String { L("noti_time5") }
        static var strTimezone6: String { L("noti_time6") }
        static var strTimezone7: String { L("noti_time7") }
        static var strTimezone8: String { L("noti_time8") }
        static var strTimezone9: String { L("noti_time9") }
        static var strTimezone10: String { L("noti_time10") }
        static var strTimezone11: String { L("noti_time11") }
        static var strTimezone12: String { L("noti_time12") }
        static var strTimezone13: String { L("noti_time13") }
        static var strTimezone14: String { L("noti_time14") }
        static var strTimezone15: String { L("noti_time15") }
    }
    
    struct addInboxMessage {
        static var strText1: String { L("inbox_title1") }
        static var strText2: String { L("inbox_title2") }
        static var strText3: String { L("inbox_title3") }
        static var strText4: String { L("inbox_title4") }
        static var strText5: String { L("inbox_title5") }
        static var strText6: String { L("inbox_title6") }
        static var strText7: String { L("inbox_title7") }
        static var strText8: String { L("inbox_title8") }
        static var strText9: String { L("inbox_title9") }
        static var strText10: String { L("inbox_title10") }
        static var strText11: String { L("inbox_title11") }
        static var strText12: String { L("inbox_title12") }
        static var strText13: String { L("inbox_title13") }
        static var strText14: String { L("inbox_title14") }
        static var strText15: String { L("inbox_title15") }
        
        static var strRightSideText1: String { L("inbox_date") }
        static var strRightSideText2: String { L("inbox_date") }
        static var strRightSideText3: String { L("inbox_date") }
        static var strRightSideText4: String { L("inbox_date") }
        static var strRightSideText5: String { L("inbox_date") }
        static var strRightSideText6: String { L("inbox_date") }
        static var strRightSideText7: String { L("inbox_date") }
        static var strRightSideText8: String { L("inbox_date") }
        static var strRightSideText9: String { L("inbox_date") }
        static var strRightSideText10: String { L("inbox_date") }
        static var strRightSideText11: String { L("inbox_date") }
        static var strRightSideText12: String { L("inbox_date") }
        static var strRightSideText13: String { L("inbox_date") }
        static var strRightSideText14: String { L("inbox_date") }
        static var strRightSideText15: String { L("inbox_date") }
        
        static var strText21: String { L("inbox_desc1") }
        static var strText22: String { L("inbox_desc2") }
        static var strText23: String { L("inbox_desc3") }
        static var strText24: String { L("inbox_desc4") }
        static var strText25: String { L("inbox_desc5") }
        static var strText26: String { L("inbox_desc6") }
        static var strText27: String { L("inbox_desc7") }
        static var strText28: String { L("inbox_desc8") }
        static var strText29: String { L("inbox_desc9") }
        static var strText210: String { L("inbox_desc10") }
        static var strText211: String { L("inbox_desc11") }
        static var strText212: String { L("inbox_desc12") }
        static var strText213: String { L("inbox_desc13") }
        static var strText214: String { L("inbox_desc14") }
        static var strText215: String { L("inbox_desc15") }
    }
}
