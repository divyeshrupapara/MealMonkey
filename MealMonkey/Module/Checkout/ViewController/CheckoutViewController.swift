import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var btnSendOrder: UIButton!
    @IBOutlet weak var tblCheckOutCard: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnSendOrder])
        
        tblCheckOutCard.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblCheckOutCard.register(UINib(nibName: "AddCardTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCardTableViewCell")
        tblCheckOutCard.register(UINib(nibName: "UPITableViewCell", bundle: nil), forCellReuseIdentifier: "UPITableViewCell")
    }
    
    @IBAction func btnSendOrderClick(_ sender: Any) {
    }
}
