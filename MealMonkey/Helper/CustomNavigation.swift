import Foundation
import UIKit

/// Extension on UIViewController to provide custom navigation bar buttons and left-aligned titles
extension UIViewController {
    
    /// Sets a left-aligned title with a back button in the navigation bar
    ///
    /// - Parameters:
    ///   - title: The text to display as the title
    ///   - font: The font for the title label (default is system font, size 24)
    ///   - textColor: The text color for title and back button (default uses named "NavigationColor" or fallback)
    ///   - target: The target object for the back button action
    ///   - action: The selector to call when the back button is tapped
    func setLeftAlignedTitleWithBack(_ title: String, font: UIFont = .systemFont(ofSize: 24), textColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary, target: Any?, action: Selector) {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = textColor
        backButton.addTarget(target, action: action, for: .touchUpInside)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        let leftItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    /// Sets a left-aligned title in the navigation bar without a back button
    ///
    /// - Parameters:
    ///   - title: The text to display as the title
    ///   - font: The font for the title label (default is system font, size 24)
    ///   - textColor: The text color for the title label (default uses named "NavigationColor" or fallback)
    func setLeftAlignedTitle(_ title: String, font: UIFont = .systemFont(ofSize: 24), textColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    /// Sets a cart button on the right side of the navigation bar
    ///
    /// - Parameters:
    ///   - target: The target object for the cart button action
    ///   - action: The selector to call when the cart button is tapped
    ///   - tintColor: The tint color for the cart button (default uses named "NavigationColor" or fallback)
    func setCartButton(target: Any?, action: Selector, tintColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary, badgeCount: Int = 0) {
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .system)
        button.setImage(cartImage, for: .normal)
        button.tintColor = tintColor
        button.addTarget(target, action: action, for: .touchUpInside)
        
        // Automatically get current cart count
        var badgeCount = 0
        if let user = CoreDataManager.shared.fetchCurrentUser() {
            badgeCount = CoreDataManager.shared.fetchCart(for: user).count
        }
        
        // Badge
        if badgeCount > 0 {
            let badge = UILabel()
            badge.text = "\(badgeCount)"
            badge.textColor = .white
            badge.backgroundColor = .systemRed
            badge.font = .systemFont(ofSize: 12, weight: .bold)
            badge.textAlignment = .center
            badge.layer.cornerRadius = 10
            badge.clipsToBounds = true
            badge.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(badge)
            
            NSLayoutConstraint.activate([
                badge.topAnchor.constraint(equalTo: button.topAnchor, constant: -4),
                badge.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 4),
                badge.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
                badge.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
        
        let cartItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = cartItem
    }
}
