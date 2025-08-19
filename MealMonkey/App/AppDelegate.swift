import UIKit
import CoreData

// Global reference to AppDelegate
var app = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - App Data Arrays
    var arrCart: [ProductModel] = []             // Stores cart products
    var arrWishlist: [ProductModel] = []         // Stores wishlist products
    var arrOrders: [[ProductModel]] = []         // Stores placed orders (array of arrays of products)
    var arrCardData: [PaymentModel] = []         // Stores saved payment card data
    
    // MARK: - Core Data Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model") // CoreData model name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Fatal error if Core Data fails to load
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Save Core Data Context
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Handle save error
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Application Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadCart()
        loadOrders()
        loadCardData()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Create new scene session configuration
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Cleanup resources for discarded scenes
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Save data before app terminates
        saveCart()
        saveOrders()
        saveCardData()
    }
    
    // MARK: - Cart Persistence
    func saveCart() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrCart) {
            UserDefaults.standard.set(encoded, forKey: "savedCart")
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadCart() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "savedCart"),
           let decoded = try? decoder.decode([ProductModel].self, from: data) {
            arrCart = decoded
        }
    }
    
    // MARK: - Orders Persistence
    func saveOrders() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrOrders) {
            UserDefaults.standard.set(encoded, forKey: "savedOrders")
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadOrders() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "savedOrders"),
           let decoded = try? decoder.decode([[ProductModel]].self, from: data) {
            arrOrders = decoded
        }
    }
    
    // MARK: - Payment Cards Persistence
    func saveCardData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrCardData) {
            UserDefaults.standard.set(encoded, forKey: "savedCardData")
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadCardData() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "savedCardData"),
           let decoded = try? decoder.decode([PaymentModel].self, from: data) {
            arrCardData = decoded
        }
    }
}
