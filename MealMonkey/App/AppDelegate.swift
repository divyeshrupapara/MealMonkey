import UIKit
import CoreData

// Global reference to AppDelegate
var app = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - App Data Arrays
    var arrCart: [ProductModel] = []             /// Stores cart products
    var arrWishlist: [ProductModel] = []         /// Stores wishlist products
    var arrOrders: [[ProductModel]] = []         /// Stores placed orders (array of arrays of products)
    var arrCardData: [PaymentModel] = []         /// Stores saved payment card data
    
    // MARK: - Core Data Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model") /// CoreData model name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /// Fatal error if Core Data fails to load
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Save Core Data Context
    /// Saves changes in Core Data context to persistent storage
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                /// Handle save error
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Application Lifecycle
    /// Called when the app finishes launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    /// Creates a new scene configuration for connecting sessions
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        /// Create new scene session configuration
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    /// Called when scenes are discarded to cleanup resources
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        /// Cleanup resources for discarded scenes
    }
    
    /// Called before the app terminates to save data
    func applicationWillTerminate(_ application: UIApplication) {
    }
}
