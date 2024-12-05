//
//  UIView+Extension.swift
//  FashionApp
//
//  Created by Engy on 11/18/24.
//

import UIKit
extension UIView {

    func addCornerRadius(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }

    func addCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }

    func addBorder( color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

    @discardableResult
    func loadNib() -> UIView? {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))

        guard let nibViews = bundle.loadNibNamed(nibName, owner: self, options: nil),
              let contentView = nibViews.first as? UIView else {
            print("Error: Could not load nib named \(nibName)")
            return nil
        }

        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return contentView
    }

    @discardableResult
    func loadNib(named nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))

        guard let nibViews = bundle.loadNibNamed(nibName, owner: self, options: nil),
              let contentView = nibViews.first as? UIView else {
            print("Error: Could not load nib named \(nibName)")
            return nil
        }

        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return contentView
    }

    @MainActor func displayEmptyMessage(_ message: String) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = ._4_D_7_E_58
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.setCustomFont(font: .gilroyBold,size: 20)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20)
        ])
    }

    @MainActor func removeEmptyMessage() {
        for subview in self.subviews {
            if let label = subview as? UILabel, label.textColor == ._4_D_7_E_58 {
                label.removeFromSuperview()
            }
        }
    }
}

