//
//  Endpoints.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import Foundation

var baseUrl = "http://www.nweave.com/wp-content/uploads/2012/09/featured.txt"

enum Endpoints {
    case products
    var path: String {
        switch self {
        case .products:
            return "\(baseUrl)"
        }
    }
}
