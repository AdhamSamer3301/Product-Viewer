//
//  NetworkService.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

import Foundation
import Alamofire

class NetworkService: GetData {
    func fetchData<T>(url: String?, completionHandler: @escaping (T?) -> Void) where T : Decodable {
        guard let url = url else { return }
        
        AF.request(url).responseDecodable(of: T.self) { response in
            switch response.result {
                case let .success(data):
                    print("Fetched")
                    completionHandler(data)
                case let .failure(error):
                    print("Error: \n")
                    print(error.localizedDescription)
                    completionHandler(nil)
            }
        }
    }
    
}
