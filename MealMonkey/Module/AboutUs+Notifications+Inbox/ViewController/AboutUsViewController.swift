import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var tblMoreOpions: UITableView!
    
    var arrCurrent: [AboutModel] = []
    var objPageType: PageType = .AboutUs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cartImage = UIImage(named: "ic_cart")?.withRenderingMode(.alwaysTemplate)
        let cartButton = UIBarButtonItem(
            image: cartImage,
            style: .plain,
            target: self,
            action: #selector(cartButtonTapped)
        )
        
        cartButton.tintColor = UIColor(red: 74/255, green: 75/255, blue: 77/255, alpha: 1.0)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = cartButton
        
        switch objPageType {
        case .PayMent:
            print("Payment")
        case .MyOrders:
            print("My Orders")
        case .Notification:
            self.title = "Notification"
            arrCurrent = AboutModel.addNotificationData()
        case .Inbox:
            self.title = "Inbox"
            arrCurrent = AboutModel.addInboxData()
        case .AboutUs:
            self.title = "About Us"
            arrCurrent = AboutModel.addAboutData()
        }
        
        tblMoreOpions.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
    }
    
    @objc func cartButtonTapped() {
    }
}
