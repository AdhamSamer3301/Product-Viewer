//
//  Protocols.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import Foundation

protocol GetData {
    static func fetchData<T>(url: String?, completionHandler: @escaping ([T]?) -> Void) where T: Decodable
}
