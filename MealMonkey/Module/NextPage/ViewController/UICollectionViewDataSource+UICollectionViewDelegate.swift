import Foundation
import UIKit

extension NextPageViewController: UICollectionViewDelegate {
}

extension NextPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrNextPageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CollectionViewCellNextPageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellNextPageCollectionViewCell", for: indexPath) as! CollectionViewCellNextPageCollectionViewCell
        
        cell.configureCell(nextPage: arrNextPageData[indexPath.item])
        
        return cell
    }
}

extension NextPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewNextPage.frame.size.width, height: 294.81)
    }
}

extension NextPageViewController: UIScrollViewDelegate {
    
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
