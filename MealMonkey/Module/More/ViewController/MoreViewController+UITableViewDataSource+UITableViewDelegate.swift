import Foundation
import UIKit

extension MoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        
        case 1:
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        
        case 2:
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                VC.objPageType = .Notification
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        case 3:
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                VC.objPageType = .Inbox
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        case 4:
            let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                VC.objPageType = .AboutUs
                self.navigationController?.pushViewController(VC, animated: true)
            }
        
        default:
            break
        }
    }
}

extension MoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrMore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        
        cell.configureMenuCell(more: arrMore[indexPath.row])
        
        return cell
    }
}

enum PageType {
    
    case PayMent
    case MyOrders
    case Notification
    case Inbox
    case AboutUs
}
