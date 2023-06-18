//
//  ViewModel.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import Foundation

class ViewModel {
    
    
    var bindDataToVC: (() -> Void) = {}
    var products: [Product]! {
        didSet {
            bindDataToVC()
        }
    }
    
    func getData(url: Endpoints) {
//        NetworkService.fetchData(url: url.path) { response in
//            self.products = response ?? []
//        }
        Task.init(operation: {
            products = try await NetworkService.fetch(url: url.path)
        })
    }
}
