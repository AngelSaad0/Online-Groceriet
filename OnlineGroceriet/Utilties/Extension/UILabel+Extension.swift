//
//  LabelCircularFont.swift
//  FashionApp
//
//  Created by Engy on 11/16/24.
//

import UIKit

extension UILabel {
    func setCustomFont(font: Fonts, size: CGFloat) {
        self.font = UIFont(name: font.rawValue, size: size)
    }
}
