//
//  ViewController.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var productsCollectionView: UICollectionView! {
        didSet {
            productsCollectionView.dataSource = self
            productsCollectionView.delegate = self
            let nib = UINib(nibName: "MainCVCell", bundle: nil)
            productsCollectionView.register(nib, forCellWithReuseIdentifier: "mainCVCell")
        }
    }

    var vm: ViewModel = ViewModel()
    var allProducts: [Product]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getData(url: .products)
        vm.bindDataToVC = { () in
            DispatchQueue.main.async {
                self.allProducts? = self.vm.products
                self.productsCollectionView.reloadData()
            }
        }
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allProducts?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailsVC = storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! ProductDetailsVC
        navigationController?.pushViewController(productDetailsVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCVCell", for: indexPath) as! MainCVCell
        
        guard let product = allProducts?[indexPath.row] else { return cell }
        return cell.configureCell(item:product)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .landscapeRight, .landscapeLeft:
            return CGSize(width: collectionView.frame.width / 2.2, height: collectionView.frame.height / 1.5)
        default:
            return CGSize(width: collectionView.frame.width / 2.2, height: collectionView.frame.height / 3)
        }
    }
}
