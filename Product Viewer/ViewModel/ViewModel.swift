//
//  ViewModel.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import Foundation

class ViewModel {
    var networkService: NetworkService = NetworkService()
    
    var bindDataToVC: (() -> Void) = {}
    var products: Product! {
        didSet {
            bindDataToVC()
        }
    }
    
    func getData(url: Endpoints) {
        networkService.fetchData(url: url.path) { response in
            self.products = response
        }
    }
}
