//
//  FiltersTVCell.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/2/24.
//

import UIKit

class FiltersTVCell: UITableViewCell {

    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .clear
        checkMarkImage.image = UIImage(named: selected ? "check":"uncheck")
    }

    func configDummyData(_ title:String) {
        titleLabel.text = title
        checkMarkImage.image = UIImage(named: "uncheck")

    }
    func configImage(_ isSelcted: Bool){

    }



}
