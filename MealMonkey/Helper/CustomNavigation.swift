import Foundation
import UIKit

/// Extension on UIViewController for custom navigation bar setup
extension UIViewController {
    
    /// Sets a left-aligned title with a back button in the navigation bar
    /// - Parameters:
    ///   - title: The title text
    ///   - font: The font for the title (default: system 24)
    ///   - textColor: Color for title and back button (default: NavigationColor or .labelPrimary)
    ///   - target: Target for the back button action
    ///   - action: Selector for the back button action
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
    
    /// Sets a left-aligned title without a back button
    /// - Parameters:
    ///   - title: The title text
    ///   - font: The font for the title (default: system 24)
    ///   - textColor: Color for the title (default: NavigationColor or .labelPrimary)
    func setLeftAlignedTitle(_ title: String, font: UIFont = .systemFont(ofSize: 24), textColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    /// Sets a cart button on the right side of the navigation bar with badge count
    /// - Parameters:
    ///   - target: Target for the cart button action
    ///   - action: Selector for the cart button action
    ///   - tintColor: Tint color for the button (default: NavigationColor or .labelPrimary)
    ///   - badgeCount: Badge count for the cart (default: 0)
    func setCartButton(target: Any?, action: Selector, tintColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary, badgeCount: Int = 0) {
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .system)
        button.setImage(cartImage, for: .normal)
        button.tintColor = tintColor
        button.frame.size = CGSize(width: 22.76, height: 20)
        button.addTarget(target, action: action, for: .touchUpInside)
        var badgeCount = 0
        if let user = CoreDataManager.shared.fetchCurrentUser() {
            let cartItems = CoreDataManager.shared.fetchCart(for: user)
            badgeCount = cartItems.reduce(0) { $0 + ($1.intProductQty ?? 0) }
        }
        if badgeCount > 0 {
            let badge = UILabel()
            badge.text = "\(badgeCount)"
            badge.textColor = .white
            badge.backgroundColor = .systemRed
            badge.font = UIFont(name: "Helvetica-Bold", size: 14)
            badge.textAlignment = .center
            badge.layer.cornerRadius = 10
            badge.clipsToBounds = true
            badge.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(badge)
            NSLayoutConstraint.activate([
                badge.topAnchor.constraint(equalTo: button.topAnchor, constant: -6),
                badge.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 4),
                badge.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
                badge.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
        let cartItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = cartItem
    }
}
