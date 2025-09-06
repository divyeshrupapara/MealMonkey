import Foundation
import UIKit

// MARK: - UITableView Delegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Return the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredProducts.count
        }
        return 4
    }
    
    /// Configure each table view cell based on row index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.HomeTableViewCell, for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        
        // Configure collection view layout (horizontal/vertical)
        if let layout = cell.collectionViewHome.collectionViewLayout as? UICollectionViewFlowLayout {
            if indexPath.row == 0 || indexPath.row == 2 {
                layout.scrollDirection = .horizontal
            } else {
                layout.scrollDirection = .vertical
            }
            cell.collectionViewHome.collectionViewLayout.invalidateLayout()
        }
        
        // Configure cell data based on row
        switch indexPath.row {
        case 0:
            // Category section
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
            // Popular section
            cell.collectionType = .popular
            cell.products = productManager.popularProducts
            if !searchQuery.isEmpty {
                cell.products = cell.products.filter { $0.strProductName.localizedCaseInsensitiveContains(searchQuery) }
            }
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.collectionViewHome.layoutIfNeeded()
            cell.collectionViewHomeHeight.constant =
                cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            cell.lblCollectionViewTitle.text = "Popular"
            
        case 2:
            // Most Popular section
            cell.collectionType = .mostPopular
            cell.products = productManager.mostPopularProducts
            if !searchQuery.isEmpty {
                cell.products = cell.products.filter { $0.strProductName.localizedCaseInsensitiveContains(searchQuery) }
            }
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Most Popular"
            cell.collectionViewHomeHeight.constant = 185
            
        case 3:
            // Recent Items section
            cell.collectionType = .RecentItems
            cell.products = productManager.recentProducts
            if !searchQuery.isEmpty {
                cell.products = cell.products.filter { $0.strProductName.localizedCaseInsensitiveContains(searchQuery) }
            }
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
    
    /// Handle table view row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: Main.StoryBoard.MenuStoryboard, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.FoodDetailViewController) as? FoodDetailViewController {
            let product = ProductDataManager.shared.allProducts[indexPath.row]
            detailVC.product = product // Pass the selected product
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    /// Return the image name for a given product category
    func imageNameForCategory(_ category: ProductCategory) -> String {
        switch category {
        case .All : return Main.Image.ic_all
        case .Punjabi: return Main.Image.ic_punjabi
        case .Chinese: return Main.Image.ic_chinese
        case .Gujarati: return Main.Image.ic_gujarati
        case .SouthIndian: return Main.Image.ic_southindian
        case .WesternFood: return Main.Image.ic_westernfood
        }
    }
}

// MARK: - HomeTableViewCell Delegate
extension HomeViewController: HomeTableViewCellDelegate {
    
    /// Handle category selection from collection view cell
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory) {
        ProductDataManager.shared.setCategory(category)
        tblHome.reloadData()
    }
    
    /// Handle product selection from collection view cell
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel) {
        ProductDataManager.shared.addRecentProduct(product.intId)
        tblHome.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
        
        let storyboard = UIStoryboard(name: Main.StoryBoard.MenuStoryboard, bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.FoodDetailViewController) as? FoodDetailViewController {
            detailVC.product = product
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UITextField Delegate
extension HomeViewController: UITextFieldDelegate {
    
    /// Handle live search on text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text as NSString? {
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            searchQuery = updatedText.trimmingCharacters(in: .whitespacesAndNewlines)
            tblHome.reloadData()
        }
        return true
    }
}
