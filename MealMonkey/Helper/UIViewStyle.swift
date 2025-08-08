import Foundation
import UIKit

class viewStyle {
    class func viewStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor,textField: [UIView]) {
        
        for item in textField {
            item.layer.cornerRadius = cornerRadius
            item.layer.borderWidth = borderWidth
            item.layer.borderColor = borderColor.cgColor
        }
    }
}

class setPadding {
    class func setPadding(left: CGFloat, right: CGFloat, textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: left, right: right)
        }
    }
}

extension UIViewController {
    func viewStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor,textField: [UIView]) {
        
        for item in textField {
            item.layer.cornerRadius = cornerRadius
            item.layer.borderWidth = borderWidth
            item.layer.borderColor = borderColor.cgColor
        }
    }
}

extension UITextField {
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
