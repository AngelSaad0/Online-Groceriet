//
//  UIView+Extension.swift
//  FashionApp
//
//  Created by Engy on 11/18/24.
//

import UIKit
extension UIView {
    func addCornerRadius(_ radius: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    func addCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
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

}

