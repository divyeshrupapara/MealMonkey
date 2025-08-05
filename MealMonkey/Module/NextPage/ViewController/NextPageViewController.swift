import UIKit

class NextPageViewController: UIViewController {

    @IBOutlet weak var collectionViewNextPage: UICollectionView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var arrNextPageData: [NextPageClass] = NextPageClass.getNextPageData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Next Page"
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(textfield: [btnDone])
        
        collectionViewNextPage.register(UINib(nibName: "CollectionViewCellNextPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellNextPageCollectionViewCell")
    }
    
    func viewStyle(textfield: [UIView]){
        
        for item in textfield {
            item.viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray)
        }
    }
    
    private func showMainTabBar() {
        
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController {

            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {

                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func btnDoneClick(_ sender: Any) {
        showMainTabBar()
    }
}
