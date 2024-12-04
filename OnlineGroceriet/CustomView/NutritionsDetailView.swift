//
//  NutritionsDetailView.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/3/24.
//

import UIKit

class NutritionsDetailView: UIView {

    @IBOutlet weak var textLabel: UILabel!

    var handelAction: (()->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commanInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commanInit()
    }

    @IBAction func closeButtonClicked(_ sender: Any) {
        handelAction?()
    }
    
    func commanInit() {
        let bundle = Bundle.init(for: NutritionsDetailView.self)
        if let ViewToAdd = bundle.loadNibNamed("NutritionsDetailView", owner: self,options: nil), let contentView = ViewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        }


    }
}
