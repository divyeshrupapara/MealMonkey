import UIKit
import Lottie

class LottieAnimationHelper {
    
    /// Show Lottie animation with a message when no data is available
    static func showEmptyState(on view: UIView, animationName: String, message: String) {
        let backgroundView = UIView(frame: view.bounds)
        
        // Lottie Animation View
        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        // Label
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.addSubview(animationView)
        backgroundView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: -40),
            animationView.widthAnchor.constraint(equalToConstant: 180),
            animationView.heightAnchor.constraint(equalToConstant: 180),
            
            messageLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16),
            messageLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
        ])
        
        // If it's a UITableView or UICollectionView, set backgroundView
        if let tableView = view as? UITableView {
            tableView.backgroundView = backgroundView
        } else if let collectionView = view as? UICollectionView {
            collectionView.backgroundView = backgroundView
        } else {
            // For any other view, just add as subview
            view.addSubview(backgroundView)
        }
    }
    
    /// Remove empty state view
    static func removeEmptyState(from view: UIView) {
        if let tableView = view as? UITableView {
            tableView.backgroundView = nil
        } else if let collectionView = view as? UICollectionView {
            collectionView.backgroundView = nil
        } else {
            view.subviews.forEach { subview in
                if subview is LottieAnimationView || subview is UILabel {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}
