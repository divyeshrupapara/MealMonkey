final class ProductDataManager {
    static let shared = ProductDataManager()
    
    var allProducts: [ProductModel] = []
    
    private init() {}
    
    func setProductsFromAPI(_ products: [ProductModel]) {
        self.allProducts = products
        self.products = products
    }
    
    private(set) var products: [ProductModel] = []
    
    private var currentCategory: ProductCategory = .All
    
    // MARK: - Update current category filter
    func setCategory(_ category: ProductCategory) {
        currentCategory = category
        if category == .All {
            products = allProducts
        } else {
            products = allProducts.filter { $0.objProductCategory == category }
        }
    }
    
    // MARK: - Fetch by ID
    func product(with id: Int) -> ProductModel? {
        return products.first { $0.intId == id }
    }
    
    // MARK: - Filter by Category (on demand)
    func products(for category: ProductCategory) -> [ProductModel] {
        if category == .All { return products }
        return products.filter { $0.objProductCategory == category }
    }
    
    // MARK: - Filter by Type
    func products(for type: ProductType) -> [ProductModel] {
        return products.filter { $0.objProductType == type }
    }
    
    // MARK: - Search
    func searchProducts(_ query: String) -> [ProductModel] {
        guard !query.isEmpty else { return products }
        let lowerQuery = query.lowercased()
        return products.filter {
            $0.strProductName.lowercased().contains(lowerQuery) ||
            $0.strProductDescription.lowercased().contains(lowerQuery)
        }
    }
    
    // MARK: - Popular
    var popularProducts: [ProductModel] {
        return products.sorted { $0.floatProductRating > $1.floatProductRating }
    }
    
    // MARK: - Most Popular (by total number of ratings)
    var mostPopularProducts: [ProductModel] {
        return products.sorted { $0.intTotalNumberOfRatings > $1.intTotalNumberOfRatings }
    }
    
    // MARK: - Recent Items
    private var recentProductIDs: [Int] = []
    
    func addRecentProduct(_ productId: Int) {
        recentProductIDs.removeAll { $0 == productId }
        recentProductIDs.insert(productId, at: 0)
        if recentProductIDs.count > 7 {
            recentProductIDs.removeLast()
        }
    }
    
    var recentProducts: [ProductModel] {
        return recentProductIDs.compactMap { id in
            allProducts.first { $0.intId == id }
        }
    }
}
