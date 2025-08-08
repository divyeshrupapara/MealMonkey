import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var txtSearchFood: UITextField!
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var tblBackView: UIView!
    
    var arrCategory: [ClassCategory] = ClassCategory.addCategory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitle("Menu")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        applyCornerRadiusTLBR()
        
        viewStyle(cornerRadius: txtSearchFood.frame.size.height/2 , borderWidth: 0, borderColor: .systemGray, textField: [txtSearchFood])
        setPadding(textfield: [txtSearchFood])
        
        tblCategory.showsVerticalScrollIndicator = false
        tblCategory.backgroundColor = .clear
        tblCategory.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    @objc func btnCartTapped() {
    }
    
    func applyCornerRadiusTLBR() {
        
        tblBackView.layer.cornerRadius = 28
        
        tblBackView.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
        ]
        
        tblBackView.clipsToBounds = true
    }
    
    func setPadding(textfield: [UITextField]){
        
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
}
