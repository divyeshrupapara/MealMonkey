import Foundation
import UIKit

extension AboutUsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCurrent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AboutUsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTableViewCell", for: indexPath) as! AboutUsTableViewCell
        
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
