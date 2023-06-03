//
//  ProductDetailsVC.swift
//  Product Viewer
//
//  Created by Adham Samer on 02/06/2023.
//

import UIKit
import CoreData
import Kingfisher

class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTxtView: UITextView!
    var product: ProductClass?
    var coreProduct: NSManagedObject?
    var flag:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        switch flag {
            case 0:
                //From api
                productName.text = product?.name
                priceLabel.text = "\(product?.price ?? "")$"
                descriptionTxtView.text = product?.description
                productImage.kf.setImage(with: URL(string: refineLink(url: product?.image_url ?? "")), placeholder: UIImage(named: "404Image"))
            case 1:
                productName.text = coreProduct?.value(forKey: "name") as? String
                priceLabel.text = "\(coreProduct?.value(forKey: "price") as? String ?? "")$"
                descriptionTxtView.text = coreProduct?.value(forKey: "details") as? String
                productImage.image = UIImage(named: "404Image")
            default:
                print("")
        }
        
    }
}

extension ProductDetailsVC {
    func refineLink(url: String?) -> String {
        return url?.replacingOccurrences(of: "http://", with: "https://") ?? ""
    }
}
