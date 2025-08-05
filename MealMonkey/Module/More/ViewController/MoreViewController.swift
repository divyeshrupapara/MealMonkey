import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet weak var tblMenu: UITableView!
    
    var arrMore: [ClassMore] = ClassMore.addMore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "More"
        self.navigationController?.isNavigationBarHidden = true
        
        tblMenu.register(UINib(nibName: "MoreTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreTableViewCell")
    }
}
