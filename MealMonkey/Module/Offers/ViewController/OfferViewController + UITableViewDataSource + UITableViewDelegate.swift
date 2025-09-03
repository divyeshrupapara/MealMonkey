import Foundation
import UIKit

/// UITableViewDataSource methods for OffersViewController
extension OffersViewController: UITableViewDataSource {
    
    /**
     Returns the number of rows in the table view section.
     
     - Parameters:
        - tableView: The UITableView requesting this information.
        - section: The index number of the section.
     - Returns: Number of offers in arrOffer array.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffer.count
    }
    
    /**
     Provides a cell object for a particular row.
     
     - Parameters:
        - tableView: The UITableView requesting the cell.
        - indexPath: The index path of the row.
     - Returns: Configured OffersTableViewCell displaying offer information.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OffersTableViewCell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.OffersTableViewCell, for: indexPath) as! OffersTableViewCell
        
        // Configure the cell with offer data
        cell.offerConfigureCell(offer: arrOffer[indexPath.row])
        return cell
    }
}
