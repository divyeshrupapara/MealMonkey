import UIKit
import CoreData

/// CoreDataManager handles all Core Data operations: saving, fetching, and updating User, Order, Cart, and Wishlist data.
class CoreDataManager {
    
    /// Shared singleton instance
    static let shared = CoreDataManager()
    
    /// Private initializer to enforce singleton
    private init() {}
    
    /// Convenience property for accessing the NSManagedObjectContext
    private var context: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // MARK: - Core Data Save
    /// Saves the current context if there are changes
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed saving context: \(error)")
            }
        }
    }
    
    // MARK: - User Management
    /// Saves a new user to Core Data
    func saveUser(name: String, email: String, mobile: String, address: String, password: String) {
        let user = User(context: context)
        user.name = name
        user.email = email
        user.mobile = mobile
        user.address = address
        user.password = password
        saveContext()
        print("User saved successfully")
    }
    
    /// Fetches a user by email and password (login)
    func fetchUser(email: String, password: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print(" Failed to fetch user: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Fetches a user by email only (used for auto-login on SplashScreen)
    func fetchUser(byEmail email: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch user by email: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Checks if an email already exists in Core Data
    func isEmailExists(email: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            return !(try context.fetch(fetchRequest).isEmpty)
        } catch {
            print("Failed to check email: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Order Management
    /// Saves an order for a specific user
    func saveOrder(for user: User, products: [ProductModel]) {
        let order = Order(context: context)
        order.date = Date()
        order.products = products.toData()
        order.user = user.email
        saveContext()
        print("Order saved for user: \(user.email ?? "")")
    }
    
    /// Fetches all orders for a specific user
    func fetchOrders(for user: User) -> [[ProductModel]] {
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user == %@", user.email ?? "")
        
        do {
            let orders = try context.fetch(fetchRequest)
            return orders.compactMap { $0.products?.toProducts() }
        } catch {
            print("Failed to fetch orders: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Cart Management
    /// Adds or updates a product in the user's cart
    func addToCart(for user: User, product: ProductModel, quantity: Int) {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@ AND id == %d", user, product.intId)
        
        do {
            if let existing = try context.fetch(request).first {
                existing.quantity += Int64(quantity)
            } else {
                let item = CartItem(context: context)
                item.id = Int64(product.intId)
                item.name = product.strProductName
                item.price = product.doubleProductPrice
                item.image = product.strProductImage
                item.quantity = Int64(quantity)
                item.user = user
            }
            saveContext()
        } catch {
            print("Add to cart failed: \(error)")
        }
    }
    
    /// Fetches the cart items for a user and converts them to ProductModel
    func fetchCart(for user: User) -> [ProductModel] {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            let items = try context.fetch(request)
            return items.map {
                ProductModel(
                    intId: Int($0.id),
                    strProductName: $0.name ?? "",
                    strProductDescription: "",
                    floatProductRating: 0.0,
                    doubleProductPrice: $0.price,
                    strProductImage: $0.image ?? "",
                    intProductQty: Int($0.quantity),
                    intTotalNumberOfRatings: 0,
                    objProductCategory: .Gujarati,
                    objProductType: .food
                )
            }
        } catch {
            print("Fetch cart failed: \(error)")
            return []
        }
    }
    
    /// Clears all cart items for a user
    func clearCart(for user: User) {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            let items = try context.fetch(request)
            for item in items {
                context.delete(item)
            }
            saveContext()
            print("Cart cleared for user: \(user.email ?? "")")
        } catch {
            print("Failed to clear cart: \(error.localizedDescription)")
        }
    }
    
    /// Removes a single product from the user's cart
    func removeFromCart(for user: User, productId: Int) {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@ AND id == %d", user, productId)
        
        do {
            if let item = try context.fetch(request).first {
                context.delete(item)
                saveContext()
                print("Removed from cart: \(item.name ?? "")")
            } else {
                print("Product not found in cart")
            }
        } catch {
            print("Failed to remove item: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Wishlist Management
    /// Adds a product to the user's wishlist
    func addToWishlist(for user: User, productId: Int) {
        let item = WishlistItem(context: context)
        item.id = Int64(productId)
        item.user = user
        saveContext()
    }
    
    /// Removes a product from the user's wishlist
    func removeFromWishlist(for user: User, productId: Int) {
        if let items = user.wishlistItems as? Set<WishlistItem>,
           let toRemove = items.first(where: { $0.id == Int64(productId) }) {
            context.delete(toRemove)
            saveContext()
        }
    }
    
    /// Checks if a product is in the user's wishlist
    func isInWishlist(for user: User, productId: Int) -> Bool {
        if let items = user.wishlistItems as? Set<WishlistItem> {
            return items.contains { $0.id == Int64(productId) }
        }
        return false
    }
    
    /// Fetches all product IDs from the user's wishlist
    func fetchWishlistIds(for user: User) -> [Int] {
        return (user.wishlistItems as? Set<WishlistItem>)?.map { Int($0.id) } ?? []
    }
    
    func saveCard(for user: User, model: PaymentModel) {
        let context = self.context
        
        let card = Card(context: context)
        card.cardNumber = "\(model.intCardNumber ?? 0)"
        card.expiryMonth = Int16(model.intExpiryMonth ?? 0)
        card.expiryYear = Int16(model.intExpiryYear ?? 0)
        card.secureCode = Int16(model.intSecureCode ?? 0)
        card.firstName = model.strFirstName ?? ""
        card.lastName = model.strLastName ?? ""
        
        // Establish relationship
        card.user = user
        
        do {
            try context.save()
        } catch {
            print("Failed to save card: \(error.localizedDescription)")
        }
    }

    func fetchCards(for user: User) -> [Card] {
        let context = self.context
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch cards: \(error.localizedDescription)")
            return []
        }
    }

    func deleteCard(for user: User, cardNumber: String) {
        let context = self.context
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@ AND cardNumber == %@", user, cardNumber)
        
        do {
            let cards = try context.fetch(request)
            for card in cards {
                context.delete(card)
            }
            try context.save()
        } catch {
            print("Failed to delete card: \(error.localizedDescription)")
        }
    }

}
