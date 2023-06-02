//
//  ViewController.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsCollectionView: UICollectionView!{
        didSet{
            productsCollectionView.dataSource = self
            productsCollectionView.delegate = self
            let nib = UINib(nibName: "MainCVCell", bundle: nil)
            productsCollectionView.register(nib, forCellWithReuseIdentifier: "mainCVCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension MainVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! ProductDetailsVC
        navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCVCell", for: indexPath) as! MainCVCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let orientation = UIDevice.current.orientation
        switch orientation {
            case .landscapeRight, .landscapeLeft:
                return CGSize(width: (collectionView.frame.width / 2.2)  , height: collectionView.frame.height / 1.5)
            default:
                return CGSize(width: (collectionView.frame.width / 2.2)  , height: collectionView.frame.height / 3)
        }
            
        
       
    }
    
}
