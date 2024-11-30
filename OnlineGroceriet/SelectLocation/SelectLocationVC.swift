//
//  SelectLocationVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/30/24.
//

import UIKit

class SelectLocationVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var supTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupTextFields()
        setupButtons()
        setupImages()
        setupContainerView()
    }
    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyMedium, size: 26)
        supTitleLabel.setCustomFont(font: .gilroyMedium, size: 16)

    }
    private func setupTextFields() {

    }
    private func setupButtons() {

    }
    private func setupImages() {

    }
    private func setupContainerView() {

    }

}
