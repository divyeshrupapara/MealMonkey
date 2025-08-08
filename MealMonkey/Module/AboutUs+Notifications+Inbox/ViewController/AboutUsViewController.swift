import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var tblMoreOpions: UITableView!
    
    var arrCurrent: [AboutModel] = []
    var objPageType: PageType = .AboutUs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        switch objPageType {
        case .PayMent:
            print("Payment")
        case .MyOrders:
            print("My Orders")
        case .Notification:
            arrCurrent = AboutModel.addNotificationData()
            setLeftAlignedTitleWithBack("Notification",
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self, action: #selector(btnCartTapped))
        case .Inbox:
            arrCurrent = AboutModel.addInboxData()
            setLeftAlignedTitleWithBack("Inbox",
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self,
                          action: #selector(btnCartTapped))
        case .AboutUs:
            arrCurrent = AboutModel.addAboutData()
            setLeftAlignedTitleWithBack("About Us",
                                        target: self,
                                        action: #selector(btnBackTapped))
            setCartButton(target: self,
                          action: #selector(btnCartTapped))
        }
        
        tblMoreOpions.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
