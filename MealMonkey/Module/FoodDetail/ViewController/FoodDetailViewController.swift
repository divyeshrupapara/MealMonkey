import UIKit

class FoodDetailViewController: UIViewController {

    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var btnMinusQty: UIButton!
    @IBOutlet weak var btnPlusQty: UIButton!
    @IBOutlet weak var btnAddToCartTitle: UIButton!
    @IBOutlet weak var btnAddToCartImage: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var viewPortion: UIView!
    @IBOutlet weak var viewIngredients: UIView!
    @IBOutlet weak var stackProtion: UIStackView!
    @IBOutlet weak var stackIngredients: UIStackView!
    @IBOutlet weak var btnProtion: UIButton!
    @IBOutlet weak var btnIngredients: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setLeftAlignedTitleWithBack("",
                                    textColor: .buttonText,
                                    target: self,
                                    action: #selector(btnBackTapped)
        )
        setCartButton(target: self,
                      action: #selector(btnCartTapped),
                      tintColor: .buttonText
        )
        
        stackProtion.isHidden = true
        stackIngredients.isHidden = true
        
        viewStyle(cornerRadius: 4, borderWidth: 0, borderColor: .systemGray, textField: [viewPortion, viewIngredients])
        
        viewStyle(cornerRadius: btnPlusQty.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnPlusQty, btnMinusQty])
        
        viewStyle(cornerRadius: btnAddToCartImage.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddToCartImage])
        
        viewStyle(cornerRadius: btnAddToCartTitle.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddToCartTitle])
        
        viewStyle(cornerRadius: lblQuantity.frame.size.height/2, borderWidth: 1, borderColor: .buttonBackground, textField: [lblQuantity])
        
        viewDetail.layer.cornerRadius = 20
        viewDetail.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewDetail.layer.shadowColor = UIColor.black.cgColor
        viewDetail.layer.shadowOpacity = 0.2
        viewDetail.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewDetail.layer.shadowRadius = 10
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }
    
    @IBAction func btnIngredientsNameClick(_ sender: Any) {
        stackIngredients.isHidden = true
    }
    
    @IBAction func btnProtionNameClick(_ sender: Any) {
        stackProtion.isHidden = true
    }
    
    @IBAction func btnIngredientsClick(_ sender: Any) {
        
        stackIngredients.isHidden = false
    }
    
    @IBAction func btnProtionClick(_ sender: Any) {
        stackProtion.isHidden = false
    }
    
    @IBAction func btnAddToCartImageClick(_ sender: Any) {
    }
    
    @IBAction func btnAddToCartTitleClick(_ sender: Any) {
    }
    
    @IBAction func btnMinusQtyClick(_ sender: Any) {
    }
    
    @IBAction func btnPlusQtyClick(_ sender: Any) {
    }
}
