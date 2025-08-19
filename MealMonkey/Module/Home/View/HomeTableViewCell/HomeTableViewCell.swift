import UIKit

// MARK: - Protocol for HomeTableViewCell Delegate
protocol HomeTableViewCellDelegate: AnyObject {
    /// Called when a category item is selected
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory)
    
    /// Called when a product item is selected
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel)
}

// MARK: - HomeTableViewCell
class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Delegate
    weak var delegate: HomeTableViewCellDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblCollectionViewTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var collectionViewHome: UICollectionView!
    @IBOutlet weak var collectionViewHomeHeight: NSLayoutConstraint!
    
    // MARK: - Collection Type Enum
    enum CollectionType {
        case category
        case popular
        case mostPopular
        case RecentItems
    }
    
    // MARK: - Properties
    var collectionType: CollectionType = .category
    var products: [ProductModel] = [] {
        didSet {
            collectionViewHome.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Register different collection view cells
        collectionViewHome.register(UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "PopularCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "MostPopularCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "MostPopularCollectionViewCell")
        collectionViewHome.register(UINib(nibName: "RecentItemsCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "RecentItemsCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBAction
    @IBAction func btnViewAllClick(_ sender: Any) {
        // TODO: Implement View All functionality
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /// Returns number of items in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    /// Configures each collection view cell based on collection type
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = products[indexPath.row]
        
        switch collectionType {
        case .category:
            let cell: HomeCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as! HomeCategoryCollectionViewCell
            let categoryProduct = products[indexPath.row]
            cell.categoryConfigureCell(category: categoryProduct)
            return cell
            
        case .popular:
            let cell: PopularCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            cell.popularConfigureCell(product: product)
            return cell
            
        case .mostPopular:
            let cell: MostPopularCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostPopularCollectionViewCell", for: indexPath) as! MostPopularCollectionViewCell
            cell.mostPopularConfigureCell(product: product)
            return cell
            
        case .RecentItems:
            let cell: RecentItemsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentItemsCollectionViewCell", for: indexPath) as! RecentItemsCollectionViewCell
            cell.recentItemConfigureCell(product: product)
            return cell
        }
    }
    
    /// Returns size for each item based on collection type
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionType == .category {
            return CGSize(width: 88, height: 113)
        } else if collectionType == .popular {
            return CGSize(width: collectionViewHome.frame.size.width, height: 242.19)
        } else if collectionType == .mostPopular {
            return CGSize(width: 228, height: 185)
        } else if collectionType == .RecentItems {
            return CGSize(width: collectionViewHome.frame.size.width, height: 79)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
    
    /// Handles selection of a collection view item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.item]

        if collectionType == .category {
            delegate?.homeTableViewCell(self, didSelectCategory: product.objProductCategory)
        } else {
            delegate?.homeTableViewCell(self, didSelectProduct: product)
        }
    }
}
