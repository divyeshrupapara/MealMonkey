import Foundation
import UIKit

/// UICollectionViewDelegate implementation for NextPageViewController
extension NextPageViewController: UICollectionViewDelegate {
}

/// UICollectionViewDataSource implementation for NextPageViewController
extension NextPageViewController: UICollectionViewDataSource {
    
    /**
     Returns the number of items in the collection view.
     
     - Parameters:
        - collectionView: The collection view requesting this information.
        - section: The section index.
     
     - Returns: Number of items in the given section.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrNextPageData.count
    }
    
    /**
     Configures and returns the cell for a given index path.
     
     - Parameters:
        - collectionView: The collection view requesting the cell.
        - indexPath: The index path of the cell.
     
     - Returns: Configured UICollectionViewCell.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCellNextPageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellNextPageCollectionViewCell", for: indexPath) as! CollectionViewCellNextPageCollectionViewCell
        cell.configureCell(nextPage: arrNextPageData[indexPath.item])
        return cell
    }
}

/// UICollectionViewDelegateFlowLayout implementation for NextPageViewController
extension NextPageViewController: UICollectionViewDelegateFlowLayout {
    
    /**
     Returns the size for the item at a given index path.
     
     - Parameters:
        - collectionView: The collection view requesting the layout information.
        - collectionViewLayout: The layout object requesting the information.
        - indexPath: The index path of the item.
     
     - Returns: CGSize representing the width and height of the cell.
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewNextPage.frame.size.width, height: 294.81)
    }
}

/// UIScrollViewDelegate implementation for NextPageViewController
extension NextPageViewController: UIScrollViewDelegate {
    
    /**
     Called when the scroll view stops decelerating. Updates the page control and page labels.
     
     - Parameter scrollView: The scroll view that ended decelerating.
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = pageNumber
        
        let currentPageData = arrNextPageData[pageNumber]
        lblTitle.text = currentPageData.strTitle
        lblDescription.text = currentPageData.strTitleDescription
        
        let buttonTitle = currentPageData.strButtonText == .Done ? "Done" : "Next"
        btnDone.setTitle(buttonTitle, for: .normal)
    }
}
