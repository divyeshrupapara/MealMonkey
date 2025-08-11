import Foundation
import UIKit

extension OffersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OffersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell", for: indexPath) as! OffersTableViewCell
        
        cell.offerConfigureCell(offer: arrOffer[indexPath.row])
        return cell
    }
}
