//
//  ViewController.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import CoreData
import Reachability
import UIKit

class MainVC: UIViewController {
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }

    @IBOutlet var noDataIMg: UIImageView!
    @IBOutlet var productsCollectionView: UICollectionView! {
        didSet {
            productsCollectionView.dataSource = self
            productsCollectionView.delegate = self
            let nib = UINib(nibName: "MainCVCell", bundle: nil)
            productsCollectionView.register(nib, forCellWithReuseIdentifier: "mainCVCell")
        }
    }

    var vm: ViewModel = ViewModel()
    var coreDataMngr = CoreDataManager.getInstance()
    var allProducts: [Product]? = []
    var searchProducts: [Product]? = []
    var coreProducts: [NSManagedObject] = []
    var searchCoreProducts: [NSManagedObject] = []
    var reachability: Reachability? = try? Reachability()
    var isNetworkAvailable: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        coreProducts = coreDataMngr.fetchFromCoreData()
        searchCoreProducts = coreDataMngr.fetchFromCoreData()
        if reachability?.connection != .unavailable {
            vm.getData(url: .products)
            vm.bindDataToVC = { () in
                DispatchQueue.main.async {
                    self.allProducts? = self.vm.products
                    self.searchProducts? = self.vm.products
                    self.productsCollectionView.reloadData()
                }
            }
            isNetworkAvailable = true
        } else {
            isNetworkAvailable = false
            showAlert(title: "No Internet", msg: "Connect to internet to get full experience") { _ in }
            if coreProducts.count == 0 && allProducts?.count == 0 {
                noDataIMg.isHidden = false
            }
        }
    }
}

// MARK: CollectionView Functions

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isNetworkAvailable {
            return allProducts?.count ?? 0
        } else {
            return coreProducts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailsVC = storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! ProductDetailsVC
        navigationController?.pushViewController(productDetailsVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCVCell", for: indexPath) as! MainCVCell

        if isNetworkAvailable {
            guard let product = allProducts?[indexPath.row] else { return cell }
            if !coreDataMngr.foundInCore(itemToSearch: product.Product?.id ?? "") {
                coreDataMngr.saveToCoreData(item: product.Product)
            }
            return cell.configureCell(item: product)
        } else {
            let product = coreProducts[indexPath.row]
            cell.productName.text = product.value(forKey: "name") as? String
            cell.productPrice.text = "\(product.value(forKey: "price") as? String ?? "")$"
            cell.productDescription.text = product.value(forKey: "details") as? String
            cell.productImage.image = UIImage(named: "404Image")
            return cell
        }
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

// MARK: Rendering

extension MainVC: UISearchBarDelegate {
    func showAlert(title: String, msg: String, handler: @escaping (UIAlertAction?) -> Void) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            handler(action)
        }))

        present(alert, animated: true, completion: nil)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isNetworkAvailable {
            allProducts = []
            if searchText.isEmpty {
                allProducts = searchProducts
            }

            for product in searchProducts ?? [] {
                if product.Product!.name!.lowercased().contains(searchText.lowercased()) {
                    allProducts?.append(product)
                }
            }

        } else {
            coreProducts = []
            if searchText.isEmpty {
                coreProducts = searchCoreProducts
            }
            
            for product in searchCoreProducts {
                let productName:String = product.value(forKey: "name") as! String
                if productName.lowercased().contains(searchText.lowercased()) {
                    coreProducts.append(product)
                }
            }
        }
        productsCollectionView.reloadData()
    }
}
