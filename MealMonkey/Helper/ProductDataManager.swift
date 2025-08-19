/// Manages all product data, filtering, searching, and tracking recent products
final class ProductDataManager {
    
    /// Shared singleton instance
    static let shared = ProductDataManager()
    
    /// All products fetched from API or other sources
    var allProducts: [ProductModel] = []
    
    /// Private initializer to enforce singleton pattern
    private init() {}
    
    /// Sets products from API and updates both allProducts and current filtered products
    ///
    /// - Parameter products: Array of ProductModel from API
    func setProductsFromAPI(_ products: [ProductModel]) {
        self.allProducts = products
        self.products = products
    }
    
    /// Current filtered products (read-only externally)
    private(set) var products: [ProductModel] = []
    
    /// Currently selected category filter
    private var currentCategory: ProductCategory = .All
    
    // MARK: - Update current category filter
    /// Updates the current category and filters products accordingly
    ///
    /// - Parameter category: Category to filter products
    func setCategory(_ category: ProductCategory) {
        currentCategory = category
        if category == .All {
            products = allProducts
        } else {
            products = allProducts.filter { $0.objProductCategory == category }
        }
    }
    
    // MARK: - Fetch by ID
    /// Fetches a single product by its unique ID
    ///
    /// - Parameter id: The product's unique identifier
    /// - Returns: Optional ProductModel matching the ID
    func product(with id: Int) -> ProductModel? {
        return products.first { $0.intId == id }
    }
    
    // MARK: - Filter by Category (on demand)
    /// Returns products filtered by a given category
    ///
    /// - Parameter category: The category to filter by
    /// - Returns: Array of ProductModel for the category
    func products(for category: ProductCategory) -> [ProductModel] {
        if category == .All { return products }
        return products.filter { $0.objProductCategory == category }
    }
    
    // MARK: - Filter by Type
    /// Returns products filtered by a given type
    ///
    /// - Parameter type: The product type to filter by
    /// - Returns: Array of ProductModel for the type
    func products(for type: ProductType) -> [ProductModel] {
        return products.filter { $0.objProductType == type }
    }
    
    // MARK: - Search
    /// Searches products by name or description containing the query string
    ///
    /// - Parameter query: Search string
    /// - Returns: Array of ProductModel matching the query
    func searchProducts(_ query: String) -> [ProductModel] {
        guard !query.isEmpty else { return products }
        let lowerQuery = query.lowercased()
        return products.filter {
            $0.strProductName.lowercased().contains(lowerQuery) ||
            $0.strProductDescription.lowercased().contains(lowerQuery)
        }
    }
    
    // MARK: - Popular
    /// Returns products sorted by rating in descending order
    var popularProducts: [ProductModel] {
        return products.sorted { $0.floatProductRating > $1.floatProductRating }
    }
    
    // MARK: - Most Popular (by total number of ratings)
    /// Returns products sorted by total number of ratings in descending order
    var mostPopularProducts: [ProductModel] {
        return products.sorted { $0.intTotalNumberOfRatings > $1.intTotalNumberOfRatings }
    }
    
    // MARK: - Recent Items
    /// Keeps track of recent product IDs (maximum 7)
    private var recentProductIDs: [Int] = []
    
    /// Adds a product ID to recent products list
    ///
    /// - Parameter productId: Product ID to mark as recently viewed
    func addRecentProduct(_ productId: Int) {
        recentProductIDs.removeAll { $0 == productId }
        recentProductIDs.insert(productId, at: 0)
        if recentProductIDs.count > 7 {
            recentProductIDs.removeLast()
        }
    }
    
    /// Returns recent products based on recentProductIDs
    var recentProducts: [ProductModel] {
        return recentProductIDs.compactMap { id in
            allProducts.first { $0.intId == id }
        }
    }
}
