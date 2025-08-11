import Foundation
class RecentItemsHelper {
    static let shared = RecentItemsHelper()
    
    private init() {}
    
    private var recentItems: [ProductModel] = []
    private let maxItems = 7
    
    func addProduct(_ product: ProductModel) {
        // Remove existing if present to avoid duplicates
        if let existingIndex = recentItems.firstIndex(where: { $0.intId == product.intId }) {
            recentItems.remove(at: existingIndex)
        }
        // Insert at beginning
        recentItems.insert(product, at: 0)
        
        // Keep only maxItems count
        if recentItems.count > maxItems {
            recentItems.removeLast()
        }
    }
    
    func getRecentItems() -> [ProductModel] {
        return recentItems
    }
    
    func clear() {
        recentItems.removeAll()
    }
}
