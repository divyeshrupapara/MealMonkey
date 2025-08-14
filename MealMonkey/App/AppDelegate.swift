import UIKit

var app = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var arrCart: [ProductModel] = []
    var arrOrders: [[ProductModel]] = []
    var arrCardData: [PaymentModel] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadCart()
        loadOrders()
        loadCardData()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
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
