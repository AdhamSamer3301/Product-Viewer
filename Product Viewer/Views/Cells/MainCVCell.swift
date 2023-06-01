//
//  MainCVCell.swift
//  Product Viewer
//
//  Created by Adham Samer on 01/06/2023.
//

import UIKit

class MainCVCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    }

}
