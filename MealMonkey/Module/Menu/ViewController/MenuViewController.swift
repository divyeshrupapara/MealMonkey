import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var txtSearchFood: UITextField!
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var tblBackView: UIView!
    
    var arrCategory: [ClassCategory] = ClassCategory.addCategory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyCornerRadiusTLBR()
        tblCategory.showsVerticalScrollIndicator = false
        tblCategory.backgroundColor = .clear
        tblCategory.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    func applyCornerRadiusTLBR() {
        
        tblBackView.layer.cornerRadius = 28
        
        tblBackView.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
        ]
        
        tblBackView.clipsToBounds = true
    }
}
