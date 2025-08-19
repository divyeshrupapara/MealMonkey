import Foundation

/// Model class representing a product category with name, item count, and image
class ClassCategory: NSObject {
    
    /// Name of the category
    var strCategoryName: String = ""
    
    /// Number of items in the category
    var intItems: Int = 0
    
    /// Image name representing the category
    var imgCategory: String = ""
    
    /// Designated initializer to create a category object
    /// - Parameters:
    ///   - strCategoryName: Name of the category
    ///   - intItems: Number of items in the category
    ///   - imgCategory: Image name for the category
    init(strCategoryName: String, intItems: Int, imgCategory: String) {
        self.strCategoryName = strCategoryName
        self.intItems = intItems
        self.imgCategory = imgCategory
    }
    
    /// Returns a sample list of categories
    /// - Returns: Array of `ClassCategory` objects
    class func addCategory() -> [ClassCategory] {
        return [
            ClassCategory(strCategoryName: "Food",
                          intItems: 25,
                          imgCategory: "ic_Food"),
            ClassCategory(strCategoryName: "Beverages",
                          intItems: 25,
                          imgCategory: "ic_Beverages"),
            ClassCategory(strCategoryName: "Desserts",
                          intItems: 25,
                          imgCategory: "ic_Desserts")
        ]
    }
}
