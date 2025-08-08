
import Foundation

class ClassCategory: NSObject {
    var strCategoryName: String = ""
    var intItems: Int = 0
    var imgCategory: String = ""
    
    init(strCategoryName: String, intItems: Int, imgCategory: String) {
        self.strCategoryName = strCategoryName
        self.intItems = intItems
        self.imgCategory = imgCategory
    }
    
    class func addCategory() -> [ClassCategory] {
        
        return [
            ClassCategory(strCategoryName: "Food",
                          intItems: 120,
                          imgCategory: "ic_Food"),
            ClassCategory(strCategoryName: "Beverages",
                          intItems: 220,
                          imgCategory: "ic_Beverages"),
            ClassCategory(strCategoryName: "Desserts",
                          intItems: 155,
                          imgCategory: "ic_Desserts"),
            ClassCategory(strCategoryName: "Promotions",
                          intItems: 25,
                          imgCategory: "ic_Promotions")
        ]
    }
}
