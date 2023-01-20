//
//  WalkThroughVC.swift
//  sichtbar
//
//  Created by Developer on 06/05/22.
//

import UIKit

class WalkThroughVC: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    var images:[String] = ["Home-guide-1", "Home-guide-2", "Home-guide-3", "Home-guide-4", "Home-guide-5", "Home-guide-6"]
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = images.count
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickNext(_ sender:UIButton) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
            let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
            let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
                   if nextItem.row < images.count {
                self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
                       pageControl.currentPage = Int(nextItem.row)
                       
                       if Int(nextItem.row) == images.count - 1 {
                           nextBtn.setTitle("Erledigt", for: .normal)
                       }else{
                           nextBtn.setTitle("Nächste", for: .normal)
                       }
                   } else {
                       isWalkThrough = true
                       
                       self.dismiss(animated: true, completion: nil)
                   }
    }
    
    @IBAction func onClickSkip(_ sender:UIButton) {
        isWalkThrough = true
        self.dismiss(animated: true, completion: nil)
    }
}

extension WalkThroughVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkThroughCVC", for: indexPath) as! WalkThroughCVC
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
      
        if Int(pageNumber) == images.count - 1 {
        
            nextBtn.setTitle("Erledigt", for: .normal)
    } else {
       
        nextBtn.setTitle("Nächste", for: .normal)
        
    }
        pageControl.currentPage = Int(pageNumber)
    }
}
