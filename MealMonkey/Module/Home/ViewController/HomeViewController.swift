import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var txtSearchFood: UITextField!
    @IBOutlet weak var tblHome: UITableView!
    
    var arrProductData: [ProductModel] = ProductModel.addProductData()
    
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
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
