import UIKit

// MARK: - Food Detail View Controller
/// Handles the food detail screen, including displaying product info, managing quantity, and handling cart/wishlist actions.
class FoodDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgFood: UIImageView!                /// Image view for food item
    @IBOutlet weak var lblFoodName: UILabel!                /// Label for food name
    @IBOutlet weak var lblFoodPrice: UILabel!               /// Label for food price
    @IBOutlet weak var lblRating: UILabel!                  /// Label for food rating
    @IBOutlet weak var lblFoodDescription: UILabel!         /// Label for food description
    @IBOutlet weak var lblTotalPrice: UILabel!              /// Label for total price
    @IBOutlet weak var viewDetail: UIView!                  /// Main detail view container
    @IBOutlet weak var btnMinusQty: UIButton!               /// Button to decrease quantity
    @IBOutlet weak var btnPlusQty: UIButton!                /// Button to increase quantity
    @IBOutlet weak var btnAddToCartTitle: UIButton!         /// Button for "Add to Cart" text
    @IBOutlet weak var btnAddToCartImage: UIButton!         /// Button for cart image
    @IBOutlet weak var lblQuantity: UILabel!                /// Label showing selected quantity
    @IBOutlet weak var viewPortion: UIView!                 /// Portion selection view
    @IBOutlet weak var viewIngredients: UIView!             /// Ingredients selection view
    @IBOutlet weak var stackProtion: UIStackView!           /// Stack view for portion options
    @IBOutlet weak var stackIngredients: UIStackView!       /// Stack view for ingredient options
    @IBOutlet weak var btnProtion: UIButton!                /// Main portion button
    @IBOutlet weak var btnProtion1: UIButton!               /// Portion option button 1
    @IBOutlet weak var btnProtion2: UIButton!               /// Portion option button 2
    @IBOutlet weak var btnProtion3: UIButton!               /// Portion option button 3
    @IBOutlet weak var btnIngredients: UIButton!            /// Main ingredients button
    @IBOutlet weak var btnIngredients1: UIButton!           /// Ingredient option button 1
    @IBOutlet weak var btnIngredients2: UIButton!           /// Ingredient option button 2
    @IBOutlet weak var btnIngredients3: UIButton!           /// Ingredient option button 3
    @IBOutlet weak var stackStar: UIStackView!              /// Stack view for star rating
    @IBOutlet weak var btnHeart: UIButton!                  /// Wishlist heart button
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! /// Loading indicator
    @IBOutlet weak var viewFoodDetail: UIView!              /// Food detail content view
    @IBOutlet weak var viewShade: UIView!                   /// Shade overlay view
    
    // MARK: - Properties
    private var appDelegate: AppDelegate? { return UIApplication.shared.delegate as? AppDelegate } /// AppDelegate reference
    var product: ProductModel?                              /// Product model for food item
    var quantity: Int = 1                                   /// Quantity of selected product
    var cartItems: [(product: ProductModel, quantity: Int)] = [] /// List of cart items
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show loading and hide details initially
        self.viewShade.isHidden = true
        self.viewFoodDetail.isHidden = true
        activityIndicator.startAnimating()
        self.navigationController?.isNavigationBarHidden = true
        
        // Delay to simulate loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.activityIndicator.stopAnimating()
            self.viewShade.isHidden = false
            self.viewFoodDetail.isHidden = false
            self.configureUI()
            self.checkWishlistStatus()
            self.activityIndicator.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
            self.setLeftAlignedTitleWithBack("", textColor: .buttonText, target: self, action: #selector(self.btnBackTapped))
            self.setCartButton(target: self, action: #selector(self.btnCartTapped), tintColor: .buttonText)
        }
        
        // Initialize quantity and set default UI
        quantity = 1
        lblQuantity.text = "\(quantity)"
        
        // Populate data if product exists
        if let product = product {
            imgFood.image = UIImage(named: product.strProductImage)
            lblFoodName.text = product.strProductName
            lblFoodDescription.text = product.strProductDescription
            lblFoodPrice.text = "\(product.doubleProductPrice) $"
            lblRating.text = "\(product.floatProductRating) Star Ratings"
        }
        
        // Hide portion and ingredient options initially
        stackProtion.isHidden = true
        stackIngredients.isHidden = true
        
        // Apply rounded corners and styles
        viewStyle(cornerRadius: 4, borderWidth: 0, borderColor: .systemGray, textField: [viewPortion, viewIngredients])
        viewStyle(cornerRadius: btnPlusQty.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnPlusQty, btnMinusQty])
        viewStyle(cornerRadius: btnAddToCartImage.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddToCartImage])
        viewStyle(cornerRadius: btnAddToCartTitle.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddToCartTitle])
        viewStyle(cornerRadius: lblQuantity.frame.size.height/2, borderWidth: 1, borderColor: .buttonBackground, textField: [lblQuantity])
        
        // Add shadow to detail view
        viewDetail.layer.cornerRadius = 20
        viewDetail.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewDetail.layer.shadowColor = UIColor.black.cgColor
        viewDetail.layer.shadowOpacity = 0.2
        viewDetail.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewDetail.layer.shadowRadius = 10
        
        // Fill stars based on rating
        fillStars(for: product?.floatProductRating ?? 0.0, in: stackStar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkWishlistStatus()
    }
    
    /// Check and update wishlist button status
    func checkWishlistStatus() {
        if let user = CoreDataManager.shared.fetchCurrentUser(), let product = product {
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
    
    /// Configure UI with product details
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
    @objc func btnBackTapped() { self.navigationController?.popViewController(animated: true) }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnIngredientsNameClick(_ sender: UIButton) {
        stackIngredients.isHidden = true
        if let selectedTitle = sender.currentTitle { btnIngredients.setTitle(selectedTitle, for: .normal) }
        for button in [btnIngredients1, btnIngredients2, btnIngredients3] { button?.isSelected = (button == sender) }
    }
    
    @IBAction func btnProtionNameClick(_ sender: UIButton) {
        stackProtion.isHidden = true
        if let selectedTitle = sender.currentTitle { btnProtion.setTitle(selectedTitle, for: .normal) }
        for button in [btnProtion1, btnProtion2, btnProtion3] { button?.isSelected = (button == sender) }
    }
    
    @IBAction func btnIngredientsClick(_ sender: Any) { stackIngredients.isHidden = false }
    @IBAction func btnProtionClick(_ sender: Any) { stackProtion.isHidden = false }
    
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
            setCartButton(target: self, action: #selector(btnCartTapped), tintColor: .buttonText)
            let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else { print(" No logged-in user found") }
    }
    
    @IBAction func btnMinusQtyClick(_ sender: Any) {
        if quantity > 1 { quantity -= 1; updatePriceAndQuantityUI() }
    }
    
    @IBAction func btnPlusQtyClick(_ sender: Any) {
        quantity += 1
        updatePriceAndQuantityUI()
    }
    
    @IBAction func btnHeartClick(_ sender: Any) {
        guard let product = product, let user = CoreDataManager.shared.fetchCurrentUser() else { return }
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
