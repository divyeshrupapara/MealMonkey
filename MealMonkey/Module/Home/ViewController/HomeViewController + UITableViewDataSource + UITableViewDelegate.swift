import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        
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
            cell.products = ProductCategory.allCases.map {
                ProductModel(
                    intId: 0,
                    strProductName: "",
                    strProductDescription: "",
                    floatProductRating: 0,
                    doubleProductPrice: 0,
                    strProductImage: imageNameForCategory($0),
                    intTotalNumberOfRatings: 0,
                    objProductCategory: $0,
                    objProductType: .food
                )
            }
            cell.lblCollectionViewTitle.isHidden = true
            cell.btnViewAll.isHidden = true
            cell.collectionViewHomeHeight.constant = 113
            
        case 1:
            cell.collectionType = .popular
            cell.products = productManager.popularProducts
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.collectionViewHome.layoutIfNeeded()
            cell.collectionViewHomeHeight.constant =
            cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Popular"
            
        case 2:
            cell.collectionType = .mostPopular
            cell.products = productManager.mostPopularProducts
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Most Popular"
            cell.collectionViewHomeHeight.constant = 185
            
        case 3:
            cell.collectionType = .RecentItems
            cell.products = productManager.recentProducts
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.collectionViewHome.layoutIfNeeded()
            cell.collectionViewHomeHeight.constant =
            cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Recent Items"
            
        default:
            break
        }
        
        cell.collectionViewHome.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController {
            let product = ProductDataManager.shared.allProducts[indexPath.row]
            
            detailVC.product = product// Pass the selected product
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func imageNameForCategory(_ category: ProductCategory) -> String {
        switch category {
        case .All : return "ic_all"
        case .Punjabi: return "ic_punjabi"
        case .Chinese: return "ic_chinese"
        case .Gujarati: return "ic_gujarati"
        case .SouthIndian: return "ic_southindian"
        case .WesternFood: return "ic_westernfood"
        }
    }
}

extension HomeViewController: HomeTableViewCellDelegate {
    
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory) {
        ProductDataManager.shared.setCategory(category)
        tblHome.reloadData()
    }
    
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel) {
        ProductDataManager.shared.addRecentProduct(product.intId)
        tblHome.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
        
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as? FoodDetailViewController {
            detailVC.product = product
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

