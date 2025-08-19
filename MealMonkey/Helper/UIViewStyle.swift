import Foundation
import UIKit

/// Class to apply visual styles to multiple UIViews
class viewStyle {
    
    /// Applies corner radius, border width, and border color to an array of UIViews
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius to apply
    ///   - borderWidth: The border width to apply
    ///   - borderColor: The border color to apply
    ///   - textField: Array of UIViews to style
    class func viewStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, textField: [UIView]) {
        for item in textField {
            item.layer.cornerRadius = cornerRadius
            item.layer.borderWidth = borderWidth
            item.layer.borderColor = borderColor.cgColor
        }
    }
}

/// Class to set padding for multiple UITextFields
class setPadding {
    
    /// Sets left and right padding for an array of UITextFields
    ///
    /// - Parameters:
    ///   - left: Left padding value
    ///   - right: Right padding value
    ///   - textfield: Array of UITextFields to apply padding
    class func setPadding(left: CGFloat, right: CGFloat, textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: left, right: right)
        }
    }
}

/// UIViewController extension to apply styles to multiple UIViews
extension UIViewController {
    
    /// Applies corner radius, border width, and border color to an array of UIViews
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius to apply
    ///   - borderWidth: The border width to apply
    ///   - borderColor: The border color to apply
    ///   - textField: Array of UIViews to style
    func viewStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, textField: [UIView]) {
        for item in textField {
            item.layer.cornerRadius = cornerRadius
            item.layer.borderWidth = borderWidth
            item.layer.borderColor = borderColor.cgColor
        }
    }
}

/// UITextField extension to add left and right padding
extension UITextField {
    
    /// Sets left and right padding for the text field
    ///
    /// - Parameters:
    ///   - left: Left padding value (default 0)
    ///   - right: Right padding value (default 0)
    func setPadding(left: CGFloat = 0, right: CGFloat = 0) {
        if left > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        if right > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
