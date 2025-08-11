import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCollectionViewTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var collectionViewHome: UICollectionView!
    @IBOutlet weak var collectionViewHomeHeight: NSLayoutConstraint!
    
    enum CollectionType {
        case category
        case popular
        case mostPopular
        case RecentItems
    }
    
    var collectionType: CollectionType = .category
    var products: [ProductModel] = [] {
        didSet {
            collectionViewHome.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    @IBAction func btnViewAllClick(_ sender: Any) {
    }
}

extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
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
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionType == .category {
            return CGSize(width: 88, height: 113)
        } else if collectionType == .popular {
            return CGSize(width: collectionViewHome.frame.size.width, height: 242.19)
        } else if collectionType == .mostPopular {
            return CGSize(width: 228, height: 185)
        } else if collectionType == .RecentItems {
            return CGSize(width: collectionViewHome.frame.size.width, height: 79)
        } else{
            return CGSize(width: 100, height: 100)
        }
    }
}
