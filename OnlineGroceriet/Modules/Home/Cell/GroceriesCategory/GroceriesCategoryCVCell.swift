//
//  CategoryCVCell.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class GroceriesCategoryCVCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        categoryNameLabel.setCustomFont(size: 20)
        contentView.addCornerRadius(20)
    }

    func configDummyData(_ cell: DummyCategory) {
        categoryImage.image = UIImage(named: cell.imageName)
        categoryNameLabel.text = cell.name
        contentView.backgroundColor =  UIColor(hex: cell.backgroundColorHex).withAlphaComponent(0.3)
        contentView.addBorder(color: UIColor(hex: cell.backgroundColorHex), width: 2)
    }

}
