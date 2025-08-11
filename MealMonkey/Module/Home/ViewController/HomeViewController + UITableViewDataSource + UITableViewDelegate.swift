import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        if let layout = cell.collectionViewHome.collectionViewLayout as? UICollectionViewFlowLayout {
            if indexPath.row == 0 || indexPath.row == 2 {
                layout.scrollDirection = .horizontal
            } else {
                layout.scrollDirection = .vertical
            }
            cell.collectionViewHome.collectionViewLayout.invalidateLayout()
        }
        
        
        switch indexPath.row {
        case 0:
            cell.collectionType = .category
            cell.lblCollectionViewTitle.isHidden = true
            cell.btnViewAll.isHidden = true
            
            // Build category list from enum
            cell.products = ProductCategory.allCases.map { category in
                ProductModel(
                    intId: 0,
                    strProductName: "",
                    strProductDescription: "",
                    floatProductRating: 0,
                    doubleProductPrice: 0,
                    strProductImage: imageNameForCategory(category),
                    intTotalNumberOfRatings: 0,
                    objProductCategory: category,
                    objProductType: .food
                )
            }
            
            cell.collectionViewHome.layoutIfNeeded()
            cell.collectionViewHomeHeight.constant =
                cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height

            
        case 1:
            cell.collectionType = .popular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.products = arrProductData.filter { $0.floatProductRating == 4.3 }
            cell.collectionViewHomeHeight.constant = cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Popular"
            
        case 2:
            cell.collectionType = .mostPopular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Most Popular"
            cell.products = arrProductData.filter { $0.floatProductRating == 4.8 }
            cell.collectionViewHomeHeight.constant = 185
            
        case 3:
            cell.collectionType = .RecentItems
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.collectionViewHomeHeight.constant = cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Recent Items"
            
        default:
            break
        }
        
        cell.collectionViewHome.reloadData()
        return cell
    }
    
    func imageNameForCategory(_ category: ProductCategory) -> String {
        switch category {
        case .All: return "ic_all"
        case .Punjabi: return "ic_punjabi"
        case .Chinese: return "ic_chinese"
        case .Gujarati: return "ic_gujarati"
        case .SouthIndian: return "ic_southindian"
        case .WesternFood: return "ic_westernfood"
        }
    }
}
