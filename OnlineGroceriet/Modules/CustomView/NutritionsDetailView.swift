//
//  NutritionsDetailView.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/3/24.
//

import UIKit

class NutritionsDetailView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var textLabel: UILabel!
    // MARK: - Properties
    var handelAction: (()->())?
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commanInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commanInit()
    }
    func commanInit() {
        let bundle = Bundle.init(for: NutritionsDetailView.self)
        if let ViewToAdd = bundle.loadNibNamed("NutritionsDetailView", owner: self,options: nil), let contentView = ViewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        }
    }
    // MARK: - Actions
    @IBAction func closeButtonClicked(_ sender: Any) {
        handelAction?()
    }
}
