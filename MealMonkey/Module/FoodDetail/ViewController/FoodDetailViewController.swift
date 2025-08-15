import UIKit

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
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
    @IBOutlet weak var stackStar: UIStackView!
    
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    var product: ProductModel?
    var quantity: Int = 1
    
    var cartItems: [(product: ProductModel, quantity: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quantity = 1
        lblQuantity.text = "\(quantity)"
        
        if let product = product {
            imgFood.image = UIImage(named: product.strProductImage)
            lblFoodName.text = product.strProductName
            lblFoodDescription.text = product.strProductDescription
            lblFoodPrice.text = "\(product.doubleProductPrice) $"
            lblRating.text = "\(product.floatProductRating) Star Ratings"
        }
        
        self.navigationController?.isNavigationBarHidden = false
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
        
        fillStars(for: product?.floatProductRating ?? 0.0, in: stackStar)
    }
    
    func fillStars(for rating: Float, in stackView: UIStackView) {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                let starIndex = Float(index) + 1.0
                
                if rating >= starIndex {
                    // Full star
                    imageView.image = UIImage(named: "ic_starFill")
                } else if rating + 0.5 >= starIndex {
                    // Half star (using same as unfilled)
                    imageView.image = UIImage(named: "ic_star")
                } else {
                    // Empty star
                    imageView.image = UIImage(named: "ic_star")
                }
            }
        }
    }
    
    func configureUI() {
        guard let product = product else { return }
        self.title = product.strProductName
        // Set the UI elements using the product's properties.
        lblFoodName.text = product.strProductName
        lblFoodDescription.text = product.strProductDescription
        imgFood.image = UIImage(named: product.strProductImage)
        lblRating.text = String(format: "%.1f (%d ratings)", product.floatProductRating, product.intTotalNumberOfRatings)
        updatePriceAndQuantityUI()
    }
    
    func updatePriceAndQuantityUI() {
        guard let product = product else { return }
        let total = product.doubleProductPrice * Double(quantity)
        lblFoodPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblTotalPrice.text = "$\(String(format: "%.2f", total))"
        lblQuantity.text = "\(quantity)"
        btnProtion.isEnabled = quantity > 1
    }
    
    func checkProduct(productToAdd: ProductModel) {
        guard let appDelegate = appDelegate else { return }
        
        // Find if the product already exists in the cart.
        if let existingIndex = appDelegate.arrCart.firstIndex(where: { $0.intId == productToAdd.intId }) {
            // If it exists, update its quantity and total price.
            appDelegate.arrCart[existingIndex].intProductQty = quantity + (productToAdd.intProductQty ?? 1)
            print("Updated \(productToAdd.strProductName) quantity to \(quantity).")
        } else {
            // If it's a new product, set its quantity and add it to the cart.
            let newProduct = productToAdd
            newProduct.intProductQty = quantity
            appDelegate.arrCart.append(newProduct)
            print("Added \(productToAdd.strProductName) with quantity \(quantity).")
        }
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
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnAddToCartTitleClick(_ sender: Any) {
        guard let product = product else { return }
        
        checkProduct(productToAdd: product)
        
        let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnMinusQtyClick(_ sender: Any) {
        if quantity > 1 {
            quantity -= 1
            updatePriceAndQuantityUI()
        }
    }
    
    @IBAction func btnPlusQtyClick(_ sender: Any) {
        quantity += 1
        updatePriceAndQuantityUI()
    }
}
