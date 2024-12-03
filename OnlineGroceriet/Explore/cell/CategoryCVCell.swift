//
//  CategoryCVCell.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        categoryNameLabel.setCustomFont(font: .gilroyBold,size: 16)
        contentView.addCornerRadius(20)
    }

    func configDummyData(_ cell: DummyCategory) {
        categoryImage.image = UIImage(named: cell.imageName)
        categoryNameLabel.text = cell.name
        contentView.backgroundColor =  UIColor(hex: cell.backgroundColorHex)
        contentView.addBorder(color: UIColor(hex: cell.backgroundColorHex).moreVivid(factor: 3.5), width: 2)
    }
    
}
