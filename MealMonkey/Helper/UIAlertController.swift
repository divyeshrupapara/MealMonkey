import Foundation
import UIKit

/// Extension on UIAlertController to provide a simple method to show alerts
extension UIAlertController {
    
    /// Displays a basic alert with a title, message, and "Ok" button
    ///
    /// - Parameters:
    ///   - title: The title of the alert
    ///   - message: The message body of the alert
    ///   - viewController: The UIViewController on which to present the alert
    class func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            // No additional action on Ok
        }))
        
        viewController.present(alert, animated: true)
    }
}
