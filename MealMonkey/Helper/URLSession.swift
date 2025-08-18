// foodApi: "https://mocki.io/v1/0a40164a-fc7b-48d6-9045-257d75b6dac3"
// food1Api: "https://mocki.io/v1/4dd44615-def8-4c8f-b267-f7e891d1a576"

import Foundation

class ApiServices {
    static func fetchProducts(completion: @escaping ([ProductModel]) -> Void) {
        guard let url = URL(string: "https://mocki.io/v1/4dd44615-def8-4c8f-b267-f7e891d1a576") else {return}
        
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
