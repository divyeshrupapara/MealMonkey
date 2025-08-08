import Foundation
import UIKit

extension CheckoutViewController: UITableViewDelegate { }

extension CheckoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CashOnDeliveryTableViewCell", for: indexPath) as! CashOnDeliveryTableViewCell
            // configure COD cell here
            return cell
            
        case 1,2,3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardTableViewCell", for: indexPath) as! AddCardTableViewCell
            // configure Add Card cell here
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UPITableViewCell", for: indexPath) as! UPITableViewCell
            // configure UPI cell here
            return cell
            
        default:
            fatalError("Unexpected row index")
        }
    }
}
