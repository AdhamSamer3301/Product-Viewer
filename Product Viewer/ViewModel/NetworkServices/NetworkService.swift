//
//  NetworkService.swift
//  Product Viewer
//
//  Created by Adham Samer on 30/05/2023.
//

//import Alamofire
import Foundation

class NetworkService: GetData {
    static func fetchData<T>(url: String?, completionHandler: @escaping ([T]?) -> Void) where T: Decodable {
        guard let myUrl = URL(string: url ?? "") else { return }

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: myUrl) { data, _, error in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode([T].self, from: data)
                //print(json)
                completionHandler(json)
            } catch {
                //print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
        /* AF.request(url).responseDecodable(of: [T]?.self) { response in
             switch response.result {
                 case let .success(data):
                     print("Fetched")
                     print(data!)
                     completionHandler(data)
                 case let .failure(error):
                     print("Error: \n")
                     print(error.localizedDescription)
                     completionHandler(nil)
             }
         } */
    }
}
