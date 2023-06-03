//
//  MainCVCell.swift
//  Product Viewer
//
//  Created by Adham Samer on 01/06/2023.
//

import UIKit
import Kingfisher

class MainCVCell: UICollectionViewCell {

    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    }

    func configureCell(item: Product) -> MainCVCell{
        
        productName.text = item.Product?.name
        productDescription.text = item.Product?.description
        productPrice.text = "\(item.Product?.price ?? "")$"
        productImage.kf.setImage(with: URL(string: item.Product?.imageUrl ?? ""))
        
        return self
    }
}
