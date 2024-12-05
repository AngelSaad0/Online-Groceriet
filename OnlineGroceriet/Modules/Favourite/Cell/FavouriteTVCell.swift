//
//  FavouriteTVCell.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/4/24.
//

import UIKit

class FavouriteTVCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setupUI() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 16)
        priceLabel.setCustomFont(font: .gilroyMedium, size: 16)
        subTitleLabel.setCustomFont(size: 14)
    }

    func config(_ cell: DummyProduct ) {
        titleLabel.text = cell.name
        priceLabel.text = "$\(cell.price)"
        subTitleLabel.text = "\(cell.quantity), Price"
        productImage.image = UIImage(named: cell.imageName)
    }

}
