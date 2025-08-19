import Foundation
import UIKit

/// UITableViewDataSource methods for AboutUsViewController
extension AboutUsViewController: UITableViewDataSource {
    
    /// Returns the number of rows in the table view section
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - section: The index number of the section
    /// - Returns: Number of rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCurrent.count
    }
    
    /// Provides a cell object for the given index path
    ///
    /// - Parameters:
    ///   - tableView: The table view requesting this cell
    ///   - indexPath: The index path specifying the location of the cell
    /// - Returns: Configured UITableViewCell for display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue reusable AboutUsTableViewCell
        let cell: AboutUsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTableViewCell", for: indexPath) as! AboutUsTableViewCell
        
        // Configure cell based on current page type
        switch objPageType {
        case .AboutUs:
            cell.configureCellAboutUs(details: arrCurrent[indexPath.row])
        case .Notification:
            cell.configureCellNotifications(details: arrCurrent[indexPath.row])
        case .Inbox:
            cell.configureCellInbox(details: arrCurrent[indexPath.row])
        default:
            return UITableViewCell()
        }
        
        return cell
    }
}
