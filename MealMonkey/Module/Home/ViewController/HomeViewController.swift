import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var txtSearchFood: UITextField!
    @IBOutlet weak var tblHome: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Good morning Akila!")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        viewStyle(cornerRadius: txtSearchFood.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchFood])
        
        setPadding.setPadding(left: 34, right: 34, textfield: [txtSearchFood])
        
        tblHome.showsVerticalScrollIndicator = false
        tblHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tblHome.reloadData()
    }
    
    @objc func btnCartTapped() {
    }
}
