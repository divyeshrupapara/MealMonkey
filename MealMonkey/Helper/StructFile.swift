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
    
    struct addAboutMessage {
        static let strText1 = "Our mission is to deliver a seamless and intuitive shopping experience that prioritizes user satisfaction. We aim to create a platform where browsing, purchasing, and managing products feels effortless, thanks to our simple user interface and reliable service."
        static let strText2 = "We are dedicated to maintaining high standards of performance, transparency, and trust. Our team continuously works to enhance app functionality, ensure data privacy, and provide responsive customer support, making your shopping journey smooth and secure."
        static let strText3 = "Your feedback matters. If you have any questions, suggestions, or encounter any issues, we’re here to help. Reach out through our support page or email us directly. Together, we strive to build a better and more inclusive experience for everyone."
        static let strText4 = "We believe that technology should serve people. That’s why we constantly refine our platform based on real user behavior and needs, aiming to make every interaction faster, simpler, and more enjoyable."
        static let strText5 = "Security is our priority. We use industry-standard protocols to safeguard your personal information and provide a safe and secure shopping environment at all times."
        static let strText6 = "We value accessibility and inclusiveness. Our platform is designed to be usable by people of all backgrounds, devices, and technical abilities, ensuring that everyone can benefit from our services."
        static let strText7 = "Sustainability matters to us. We support eco-friendly business practices and work with partners who share our values to reduce our environmental impact."
    }
    
    struct addNotiMessage {
        static let strText1 = "Order placed successfully"
        static let strText2 = "Your payment has been confirmed"
        static let strText3 = "Your food is being prepared"
        static let strText4 = "Delivery agent assigned"
        static let strText5 = "Your order is on the way"
        static let strText6 = "Special discount available!"
        static let strText7 = "Download our new app update"
        static let strText8 = "Refer a friend and earn"
        static let strText9 = "Limited-time deal ending soon"
        static let strText10 = "Delivery completed"
        static let strText11 = "Rate your last meal"
        static let strText12 = "Weekend offer just for you"
        static let strText13 = "Free delivery on orders above ₹299"
        static let strText14 = "Thanks for being with us!"
        static let strText15 = "New restaurants added near you"
        static let strTimezone1 = "Just now"
        static let strTimezone2 = "5m ago"
        static let strTimezone3 = "10m ago"
        static let strTimezone4 = "30m ago"
        static let strTimezone5 = "1h ago"
        static let strTimezone6 = "2h ago"
        static let strTimezone7 = "3h ago"
        static let strTimezone8 = "5h ago"
        static let strTimezone9 = "12h ago"
        static let strTimezone10 = "1d ago"
        static let strTimezone11 = "2d ago"
        static let strTimezone12 = "3d ago"
        static let strTimezone13 = "5d ago"
        static let strTimezone14 = "6d ago"
        static let strTimezone15 = "1w ago"
    }
    
    struct addInboxMessage {
        
        static let strText1 = "MealMonkey Promotions"
        static let strText2 = "Order Update"
        static let strText3 = "Delivery Reminder"
        static let strText4 = "Welcome to MealMonkey"
        static let strText5 = "Rate Your Experience"
        static let strText6 = "Flash Sale"
        static let strText7 = "New Restaurants"
        static let strText8 = "Refer & Earn"
        static let strText9 = "Weekend Special"
        static let strText10 = "MealMonkey Tips"
        static let strText11 = "Order Cancelled"
        static let strText12 = "Loyalty Program"
        static let strText13 = "Security Update"
        static let strText14 = "Account Verified"
        static let strText15 = "Limited Time Deal"
        
        static let strRightSideText1 = "6th July"
        static let strRightSideText2 = "6th July"
        static let strRightSideText3 = "6th July"
        static let strRightSideText4 = "6th July"
        static let strRightSideText5 = "6th July"
        static let strRightSideText6 = "6th July"
        static let strRightSideText7 = "6th July"
        static let strRightSideText8 = "6th July"
        static let strRightSideText9 = "6th July"
        static let strRightSideText10 = "6th July"
        static let strRightSideText11 = "6th July"
        static let strRightSideText12 = "6th July"
        static let strRightSideText13 = "6th July"
        static let strRightSideText14 = "6th July"
        static let strRightSideText15 = "6th July"
        
        static let strText21 = "Get 20% off on your next meal!"
        static let strText22 = "Your order is being prepared by the restaurant."
        static let strText23 = "Your delivery agent is on the way."
        static let strText24 = "Thanks for joining us! Start exploring meals."
        static let strText25 = "How was your recent meal order?"
        static let strText26 = "Enjoy 30% off on all pasta orders today only."
        static let strText27 = "Discover trending restaurants in your area."
        static let strText28 = "Invite friends and earn ₹100 credits!"
        static let strText29 = "Free dessert on orders above ₹499."
        static let strText210 = "Customize your orders with special instructions."
        static let strText211 = "Your order has been cancelled as requested."
        static let strText212 = "Collect Monkey Points with every purchase."
        static let strText213 = "Your password was recently changed."
        static let strText214 = "Your account has been successfully verified."
        static let strText215 = "Flat ₹50 off on biryani orders today."
    }
}
