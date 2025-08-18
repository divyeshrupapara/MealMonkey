import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    private var context: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed saving context: \(error)")
            }
        }
    }
    
    // Save user
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
    
    // Fetch user by email & password
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
    
    // Fetch user by email only (for SplashScreen auto-login)
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
    
    // Check if email already exists
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
    
    // Save order for a user
    func saveOrder(for user: User, products: [ProductModel]) {
        let order = Order(context: context)
        order.date = Date()
        order.products = products.toData()
        order.user = user.email
        saveContext()
        print("Order saved for user: \(user.email ?? "")")
    }
    
    // Fetch all orders for a user
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
    
    // Add/update cart item
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
    
    // Fetch cart -> back to ProductModel
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
    
    // Clear all cart items for a user
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
    
    // Remove a single product from the user's cart
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
}
