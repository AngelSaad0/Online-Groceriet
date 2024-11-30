//
//  UIColor+Extension.swift
//  FashionApp
//
//  Created by Engy on 11/19/24.
//

import UIKit

extension UIColor {

    convenience init?(colorName: String) {
        let lowercasedColor = colorName.lowercased()

        switch lowercasedColor {
        case "red":
            self.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case "blue":
            self.init(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case "green":
            self.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        case "black":
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case "white":
            self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case "yellow":
            self.init(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        case "lemon":
            self.init(red: 1.0, green: 0.98, blue: 0.8, alpha: 1.0)
        case "gray", "grey":
            self.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        case "orange":
            self.init(red: 1.0, green: 0.647, blue: 0.0, alpha: 1.0)
        case "purple":
            self.init(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
        case "pink":
            self.init(red: 1.0, green: 0.41, blue: 0.71, alpha: 1.0)
        case "brown":
            self.init(red: 0.59, green: 0.29, blue: 0.0, alpha: 1.0)
        case "beige":
            self.init(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.0)
        case "navy":
            self.init(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0)
        case "lime":
            self.init(red: 0.75, green: 1.0, blue: 0.0, alpha: 1.0)
        case "gold":
            self.init(red: 1.0, green: 0.843, blue: 0.0, alpha: 1.0)
        case "cyan":
            self.init(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case "magenta":
            self.init(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case "teal":
            self.init(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)
        case "silver":
            self.init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        case "maroon":
            self.init(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0)
        case "olive":
            self.init(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
        case "coral":
            self.init(red: 1.0, green: 0.498, blue: 0.313, alpha: 1.0)
        case "salmon":
            self.init(red: 0.98, green: 0.5, blue: 0.45, alpha: 1.0)
        case "lavender":
            self.init(red: 0.9, green: 0.9, blue: 0.98, alpha: 1.0)
        case "indigo":
            self.init(red: 0.29, green: 0.0, blue: 0.51, alpha: 1.0)
        case "peach":
            self.init(red: 1.0, green: 0.87, blue: 0.68, alpha: 1.0)
        default:
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)        }
    }
}
