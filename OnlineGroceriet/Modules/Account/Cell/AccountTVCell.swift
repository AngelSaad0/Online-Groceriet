//
//  AccountTVCell.swift
//  FashionApp
//
//  Created by Engy on 11/17/24.
//

import UIKit

class AccountTVCell: UITableViewCell {

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var settingImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        titleLbl.setCustomFont(size: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func config(_ cell: DummyAccountSetting) {
        titleLbl.text = cell.rawValue
        settingImage.image = UIImage(named: cell.imageName)
    }
}

