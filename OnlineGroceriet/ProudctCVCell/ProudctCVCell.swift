//
//  ProudctCVCell.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class ProudctCVCell: UICollectionViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var isFavoriteButton: UIButton!
    var isClickedBtn = false
    var productId: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        productNameLabel.setCustomFont(font: .gilroyBold,size: 16)
        productPriceLabel.setCustomFont(font: .gilroyBold,size: 18)
        productQuantityLabel.setCustomFont(size: 18)
        contentView.addBorder(color: .c7Bcb6, width: 1)
        addProductButton.addCornerRadius(18)
        contentView.addCornerRadius(18)

    }

    func configDummyData(_ cell: DummyProduct) {
        productNameLabel.text = cell.name
        productPriceLabel.text = "$\(cell.price)"
        productQuantityLabel.text = "\(cell.quantity), Price"
        productImage.image = UIImage(named: cell.imageName)
        productId = cell.id
        let isFavorite = FavoritesManager.shared.isProductInFavorites(productId: cell.id)
        isFavoriteButton.setImage(UIImage(named: isFavorite ? "heart.fill" : "heart"), for: .normal)
        isClickedBtn = isFavorite
    }


    @IBAction func favortButtonClicked(_ sender: UIButton) {
        isClickedBtn.toggle()
        let imagName = isClickedBtn ? "heart.fill": "heart"
        sender.setImage(UIImage(named: imagName), for: .normal)
        manageAddToFavorite()

    }
    private func manageAddToFavorite() {
        guard let productId = productId else { return }

        if isClickedBtn {
            FavoritesManager.shared.addProduct(productId: productId)
            print("Product added to favorites")
        } else {
            FavoritesManager.shared.removeProduct(productId: productId)
            print("Product removed from favorites")
        }
    }
}


