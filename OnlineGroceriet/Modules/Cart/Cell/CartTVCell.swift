//
//  CartTVCell.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/4/24.
//

import UIKit

class CartTVCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var minusButtonContainer: UIView!
    @IBOutlet weak var plusButtonContainer: UIView!

    var onItemCountChange: ((Double) -> Void)?
    var deleteButtonClicked: (() -> Void)?

    private var productPrice = 0.0
    private var productID: Int?
    private var count = 1 {
        didSet {
            updateTotalPrice()
            updateButtonState()
            if let productID = productID {
                CartManager.shared.updateProductQuantity(productId: productID, quantity: count)

            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 16)
        priceLabel.setCustomFont(font: .gilroyMedium, size: 16)
        subTitleLabel.setCustomFont(size: 14)
        plusButtonContainer.addCornerRadius(17)
        minusButtonContainer.addCornerRadius(17)
        minusButtonContainer.addBorder(color: .F_2_F_3_F_2, width: 1)
        plusButtonContainer.addBorder(color: .F_2_F_3_F_2, width: 1)
    }

    func config(product: DummyProduct, quantity: Int) {
        productPrice = product.price
        productID = product.id
        count = quantity
        titleLabel.text = product.name
        priceLabel.text = "$\(product.price)"
        subTitleLabel.text = "\(product.quantity), Price"
        productImage.image = UIImage(named: product.imageName)
        updateTotalPrice()
    }
    func updateButtonState() {
        plusButton.setImage(UIImage(named: count==5 ? "plusUnActive":"plusActive"), for: .normal)
        minusButton.setImage(UIImage(named: count==1 ? "minusUnActive":"minusActive"), for: .normal)
    }

    private func updateTotalPrice() {
        let oldPrice = Double(priceLabel.text?.replacingOccurrences(of: "$", with: "") ?? "") ?? 0.0
        let newPrice = productPrice * Double(count)
        quantityLabel.text = "\(count)"
        priceLabel.text = "$\(newPrice)"
        let difference = newPrice - oldPrice
        onItemCountChange?(difference)
    }
    @IBAction func plusButtonClicked(_ sender: Any) {
        if count < 5 {
            count += 1
        } else {
            displayMessage(massage: .maxQuantity)
        }
    }

    @IBAction func minusButtonClicked(_ sender: Any) {
        if count > 1 {
            count -= 1
        }else {
            displayMessage(massage: .minQuantity)

        }
    }
    @IBAction func deleteButtonClicked(_ sender: Any) {
        deleteButtonClicked?()
    }
}
