// foodApi: "https://mocki.io/v1/0a40164a-fc7b-48d6-9045-257d75b6dac3"
// food1Api: "https://mocki.io/v1/e3b12f70-2d6b-4299-910a-50ade8e0a645"

import Foundation

/// Provides API services for fetching products
class ApiServices {
    
    /// Fetches products from the API
    ///
    /// - Parameter completion: Closure called on the main thread with an array of ProductModel
    static func fetchProducts(completion: @escaping ([ProductModel]) -> Void) {
        guard let url = URL(string: "https://mocki.io/v1/e3b12f70-2d6b-4299-910a-50ade8e0a645") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            
            do {
                let products = try JSONDecoder().decode([ProductModel].self, from: data)
                
                DispatchQueue.main.async {
                    completion(products)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
