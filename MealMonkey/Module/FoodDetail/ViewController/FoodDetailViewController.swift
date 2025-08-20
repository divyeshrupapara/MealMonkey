import UIKit

// MARK: - Food Detail View Controller
class FoodDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
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
    @IBOutlet weak var btnProtion1: UIButton!
    @IBOutlet weak var btnProtion2: UIButton!
    @IBOutlet weak var btnProtion3: UIButton!
    @IBOutlet weak var btnIngredients: UIButton!
    @IBOutlet weak var btnIngredients1: UIButton!
    @IBOutlet weak var btnIngredients2: UIButton!
    @IBOutlet weak var btnIngredients3: UIButton!
    @IBOutlet weak var stackStar: UIStackView!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewFoodDetail: UIView!
    @IBOutlet weak var viewShade: UIView!
    // MARK: - Properties
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    var product: ProductModel?
    var quantity: Int = 1
    var cartItems: [(product: ProductModel, quantity: Int)] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Added activity indicator
        self.viewShade.isHidden = true
        self.viewFoodDetail.isHidden = true
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.activityIndicator.stopAnimating()
            self.viewShade.isHidden = false
            self.viewFoodDetail.isHidden = false
            self.configureUI()
            self.checkWishlistStatus()
            self.activityIndicator.isHidden = true
        }
        
        // Initialize quantity and UI
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
        setLeftAlignedTitleWithBack("", textColor: .buttonText, target: self, action: #selector(btnBackTapped))
        setCartButton(target: self, action: #selector(btnCartTapped), tintColor: .buttonText)
        
        // Hide portions and ingredients stacks initially
        stackProtion.isHidden = true
        stackIngredients.isHidden = true
        
        // Apply UI styles
        viewStyle(cornerRadius: 4, borderWidth: 0, borderColor: .systemGray, textField: [viewPortion, viewIngredients])
        viewStyle(cornerRadius: btnPlusQty.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnPlusQty, btnMinusQty])
        viewStyle(cornerRadius: btnAddToCartImage.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddToCartImage])
        viewStyle(cornerRadius: btnAddToCartTitle.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddToCartTitle])
        viewStyle(cornerRadius: lblQuantity.frame.size.height/2, borderWidth: 1, borderColor: .buttonBackground, textField: [lblQuantity])
        
        // Detail view corner radius and shadow
        viewDetail.layer.cornerRadius = 20
        viewDetail.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewDetail.layer.shadowColor = UIColor.black.cgColor
        viewDetail.layer.shadowOpacity = 0.2
        viewDetail.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewDetail.layer.shadowRadius = 10
        
        // Fill star rating
        fillStars(for: product?.floatProductRating ?? 0.0, in: stackStar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkWishlistStatus()
    }
    
    func checkWishlistStatus() {
        // Wishlist button setup based on Core Data
        if let user = CoreDataManager.shared.fetchCurrentUser(),
           let product = product {
            if CoreDataManager.shared.isInWishlist(for: user, productId: product.intId) {
                btnHeart.setImage(UIImage(named: "ic_heart"), for: .normal)
            } else {
                btnHeart.setImage(UIImage(named: "ic_heart_unfill"), for: .normal)
            }
        }
    }
    // MARK: - Helper Methods
    
    /// Fill the star rating UI
    func fillStars(for rating: Float, in stackView: UIStackView) {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                let starIndex = Float(index) + 1.0
                if rating >= starIndex {
                    imageView.image = UIImage(named: "ic_starFill")
                } else if rating + 0.5 >= starIndex {
                    imageView.image = UIImage(named: "ic_star")
                } else {
                    imageView.image = UIImage(named: "ic_star")
                }
            }
        }
    }
    
    /// Update UI elements for product details
    func configureUI() {
        guard let product = product else { return }
        lblFoodName.text = product.strProductName
        lblFoodDescription.text = product.strProductDescription
        imgFood.image = UIImage(named: product.strProductImage)
        lblRating.text = String(format: "%.1f (%d ratings)", product.floatProductRating, product.intTotalNumberOfRatings)
        updatePriceAndQuantityUI()
    }
    
    /// Update price and quantity labels
    func updatePriceAndQuantityUI() {
        guard let product = product else { return }
        let total = product.doubleProductPrice * Double(quantity)
        lblFoodPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblTotalPrice.text = "$\(String(format: "%.2f", total))"
        lblQuantity.text = "\(quantity)"
        btnProtion.isEnabled = quantity >= 1
    }
    
    /// Check if product exists in cart and update quantity
    func checkProduct(productToAdd: ProductModel) {
        guard let appDelegate = appDelegate else { return }
        if let existingIndex = appDelegate.arrCart.firstIndex(where: { $0.intId == productToAdd.intId }) {
            appDelegate.arrCart[existingIndex].intProductQty = quantity + (productToAdd.intProductQty ?? 1)
            print("Updated \(productToAdd.strProductName) quantity to \(quantity).")
        } else {
            let newProduct = productToAdd
            newProduct.intProductQty = quantity
            appDelegate.arrCart.append(newProduct)
            print("Added \(productToAdd.strProductName) with quantity \(quantity).")
        }
    }
    
    // MARK: - IBActions
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnIngredientsNameClick(_ sender: UIButton) {
        stackIngredients.isHidden = true
        
        // Set main button title to the tapped button’s title
        if let selectedTitle = sender.currentTitle {
            btnIngredients.setTitle(selectedTitle, for: .normal)
        }
        
        // visually mark selected button
        for button in [btnIngredients1, btnIngredients2, btnIngredients3] {
            button?.isSelected = (button == sender)
        }
    }
    
    @IBAction func btnProtionNameClick(_ sender: UIButton) {
        stackProtion.isHidden = true
        
        // Set main button title to the tapped button’s title
        if let selectedTitle = sender.currentTitle {
            btnProtion.setTitle(selectedTitle, for: .normal)
        }
        
        // visually mark selected button
        for button in [btnProtion1, btnProtion2, btnProtion3] {
            button?.isSelected = (button == sender)
        }
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
        if let user = CoreDataManager.shared.fetchCurrentUser() {
            CoreDataManager.shared.addToCart(for: user, product: product, quantity: quantity)
            let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            print(" No logged-in user found")
        }
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
    
    @IBAction func btnHeartClick(_ sender: Any) {
        guard let product = product,
              let user = CoreDataManager.shared.fetchCurrentUser() else { return }
        
        if CoreDataManager.shared.isInWishlist(for: user, productId: product.intId) {
            CoreDataManager.shared.removeFromWishlist(for: user, productId: product.intId)
            btnHeart.setImage(UIImage(named: "ic_heart_unfill"), for: .normal)
        } else {
            CoreDataManager.shared.addToWishlist(for: user, productId: product.intId)
            btnHeart.setImage(UIImage(named: "ic_heart"), for: .normal)
        }
    }
}

// MARK: - CoreDataManager Extension
extension CoreDataManager {
    
    /// Fetch the currently logged-in user from UserDefaults
    func fetchCurrentUser() -> User? {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail") {
            return fetchUser(byEmail: email)
        }
        return nil
    }
}
