//
//  AccountVC.swift
//  FashionApp
//
//  Created by Engy on 11/15/24.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet var accountImg: UIImageView!
    @IBOutlet var accountNameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var signOutButtonContainer: UIView!
    @IBOutlet var tableView: UITableView!
    var settings = DummyAccountSetting.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupImages()
        setupContainerView()
    }
    private func setupLabels() {
        accountNameLbl.setCustomFont(font: .gilroyBold, size: 18)
        emailLbl.setCustomFont(font: .gilroyMedium, size: 16)

    }


    private func setupImages() {
        accountImg.layer.cornerRadius = accountImg.frame.height/2
    }
    private func setupContainerView() {
        signOutButtonContainer.addCornerRadius(20)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerTVNib(cell: AccountTVCell.self)
    }

    @IBAction func editBtnClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Change Youe Name", message: "", preferredStyle: .alert)
        alert.addTextField { userNameText in
            userNameText.text = self.accountNameLbl.text
        }
        alert.addAction(UIAlertAction(title: "Edit", style: .default) { _ in
            self.accountNameLbl.text = alert.textFields?[0].text
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }

    @IBAction func signoutBtnClicked(_ sender: Any) {
        UserDefaultsManager.shared.logout()
        UIWindow.setRootViewController(viewController: SignInViewController())
    }
}

extension AccountVC: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTVCell(index: indexPath,cell: AccountTVCell.self)
        cell.config(settings[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {64}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {

        default: return
        }
    }
}
