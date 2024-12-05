//
//  CheckoutVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/5/24.
//

import UIKit

class CheckoutVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: [UILabel]!
    @IBOutlet var containerView: UIView!
    // MARK: - Properties
    var totalCost: Double = 0.0
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - Helper Method
    private func setupUI() {
        allLabels.forEach{$0.setCustomFont(size: 14)}
        subTitleLabel.forEach{$0.setCustomFont(font: .gilroyMedium, size: 14)}
        titleLabel.setCustomFont(font: .gilroyBold, size: 18)
        containerView.addCornerRadius(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 20)
        priceLabel.text = "$\(totalCost)"
    }
    // MARK: - Actions
    @IBAction func closedButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func checkOutButtonCliked(_ sender: Any) {
        CartManager.shared.removeAllProduct()
        presentDetail(OrderAcceptedVC())
    }
}
