//
//  MainCVCell.swift
//  Product Viewer
//
//  Created by Adham Samer on 01/06/2023.
//

import Kingfisher
import UIKit

class MainCVCell: UICollectionViewCell {
    @IBOutlet var productDescription: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    }

    func configureCell(item: Product) -> MainCVCell {
        productName.text = item.Product?.name
        productDescription.text = item.Product?.description
        productPrice.text = "\(item.Product?.price ?? "")$"
        productImage.kf.setImage(with: URL(string: refineLink(url: item.Product?.image_url ?? "")), placeholder: UIImage(named: "404Image"))

        return self
    }
}

extension MainCVCell {
    func refineLink(url: String?) -> String {
        return url?.replacingOccurrences(of: "http://", with: "https://") ?? ""
    }
}
