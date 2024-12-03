//
//  FiltersVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/2/24.
//

import UIKit

class FiltersVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var containerView: UIView!

    let categoryList = Array(Set(dummyProducts.map{$0.category})).sorted()
    let brandList = Array(Set(dummyProducts.map{$0.brand})).sorted()
    let headers = ["Categories", "Brand"]

    var userClearData = false
    var filterBrandList = Set<String>()
    var filterCategoryList = Set<String>()
    var filterResult: ((Set<String>, Set<String>) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupButtons()
        setupContainerView()
    }

    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 20)
    }

    private func setupButtons() {
        filterButton.setCustomFont(size: 18)
        filterButton.addCornerRadius(20)
    }

    private func setupContainerView() {
        containerView.addCornerRadius(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 25)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerTVNib(cell: FiltersTVCell.self)
        tableView.reloadData()
        setupSelection()
    }

    private func setupSelection() {
        for (index, category) in categoryList.enumerated() {
            if filterCategoryList.contains(category) {
                tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
            }
        }
        for (index, brand) in brandList.enumerated() {
            if filterBrandList.contains(brand) {
                tableView.selectRow(at: IndexPath(row: index, section: 1), animated: false, scrollPosition: .none)
            }
        }
    }

    // MARK: - Actions
    @IBAction func filterButtonClicked(_ sender: Any) {
        filterResult?(filterCategoryList, filterBrandList)
        dismiss(animated: true)
    }

    @IBAction func dismissButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func clearButtonClicked(_ sender: Any) {
        userClearData = true
        filterCategoryList.removeAll()
        filterBrandList.removeAll()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FiltersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return categoryList.count
        default: return brandList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FiltersTVCell = tableView.dequeueTVCell(index: indexPath, cell: FiltersTVCell.self)
        switch indexPath.section {
        case 0:
            let isSelected = filterCategoryList.contains(categoryList[indexPath.row])
            cell.configImage(isSelected)
            cell.configDummyData(categoryList[indexPath.row])
        default:
            let isSelected = filterBrandList.contains(brandList[indexPath.row])
            cell.configImage(isSelected)
            cell.configDummyData(brandList[indexPath.row])
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FiltersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            filterCategoryList.insert(categoryList[indexPath.row])
        default:
            filterBrandList.insert(brandList[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            filterCategoryList.remove(categoryList[indexPath.row])
        default:
            filterBrandList.remove(brandList[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.setCustomFont(size: 24)
        header.textLabel?.textColor = UIColor(hex: "#181725")
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(hex: "#F2F3F2")
        header.backgroundView = backgroundView
    }
}
