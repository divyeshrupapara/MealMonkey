import UIKit

/// ViewController that manages the onboarding flow with multiple pages.
class NextPageViewController: UIViewController {
    
    /// UICollectionView displaying the onboarding pages.
    @IBOutlet weak var collectionViewNextPage: UICollectionView!
    
    /// UIButton to navigate to the next page or finish the onboarding.
    @IBOutlet weak var btnDone: UIButton!
    
    /// UIPageControl to indicate the current onboarding page.
    @IBOutlet weak var pageControl: UIPageControl!
    
    /// UILabel to display the title of the current page.
    @IBOutlet weak var lblTitle: UILabel!
    
    /// UILabel to display the description of the current page.
    @IBOutlet weak var lblDescription: UILabel!
    
    /// Array holding the data for each onboarding page.
    var arrNextPageData: [NextPageClass] = NextPageClass.getNextPageData()
    
    /// Called after the view has been loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Next Page"
        self.navigationController?.isNavigationBarHidden = true
        
        // Apply styling to the Done button.
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnDone])
        
        // Register the collection view cell.
        collectionViewNextPage.register(UINib(nibName: "CollectionViewCellNextPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellNextPageCollectionViewCell")
    }
    
    /**
     Sets the MainTabViewController as the rootViewController to show the main app interface.
     */
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
    
    /**
     Handles the tap event for the Done button.
     
     - Parameter sender: The UIButton triggering the action.
     
     If the current page's button text is `.Next`, scrolls to the next page.
     If the current page's button text is `.Done`, shows the main tab bar.
     */
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
