import UIKit

class DessertsViewController: UIViewController {

    @IBOutlet weak var txtSearchDesserts: UITextField!
    @IBOutlet weak var tblDesserts: UITableView!
    @IBOutlet weak var lblNoItem: UILabel!
    
    let productManager = ProductDataManager.shared
    var selectedProductType: ProductType = .Desserts

    var arrProducts: [ProductModel] {
        return productManager.products(for: selectedProductType)
    }
    var allProducts: [ProductModel] = []
    var filteredProducts: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNoItem.isHidden = true
        
        viewStyle(cornerRadius: txtSearchDesserts.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchDesserts])
        
       setPadding.setPadding(left: 34, right: 34, textfield: [txtSearchDesserts])
        
        txtSearchDesserts.delegate = self
        allProducts = productManager.products(for: selectedProductType)
           filteredProducts = allProducts
        
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack(
                "Food",
                target: self,
                action: #selector(btnBackTapped)
            )
            tblDesserts.reloadData()

        case .Beverages:
            setLeftAlignedTitleWithBack(
                "Beverages",
                target: self,
                action: #selector(btnBackTapped)
            )
            tblDesserts.reloadData()

        case .Desserts:
            setLeftAlignedTitleWithBack(
                "Desserts",
                target: self,
                action: #selector(btnBackTapped)
            )
            tblDesserts.reloadData()
        }
        setCartButton(target: self,
                      action: #selector(btnCartTapped))
        
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil), forCellReuseIdentifier: "DessertsTableViewCell")
        tblDesserts.reloadData()
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
