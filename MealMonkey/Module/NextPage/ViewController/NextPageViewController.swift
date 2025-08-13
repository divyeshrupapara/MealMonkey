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
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnDone])
        
        collectionViewNextPage.register(UINib(nibName: "CollectionViewCellNextPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellNextPageCollectionViewCell")
    }
    
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController {
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func btnDoneClick(_ sender: Any) {
        let currentIndex = pageControl.currentPage
        
        if arrNextPageData[currentIndex].strButtonText == .Next {
            let nextIndex = currentIndex + 1
            if nextIndex < arrNextPageData.count {
                let indexPath = IndexPath(item: nextIndex, section: 0)
                collectionViewNextPage.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
                pageControl.currentPage = nextIndex
                lblTitle.text = arrNextPageData[nextIndex].strTitle
                lblDescription.text = arrNextPageData[nextIndex].strTitleDescription
                let buttonTitle = arrNextPageData[nextIndex].strButtonText == .Done ? "Done" : "Next"
                btnDone.setTitle(buttonTitle, for: .normal)
            }
        } else {
            showMainTabBar()
        }
    }
}
