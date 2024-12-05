//
//  ExploreVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit
import IQKeyboardManagerSwift

class ExploreVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Properties
    var dummyCategoryList = dummyCategory
    var dummyProductList = dummyProducts
    var isBeginSearch = false
    var searchText = ""
    var filtterProductList = dummyProducts
    var filtterBrandList = Set<String>()
    var filtterCategotyList = Set<String>()

    private var cellWidth: CGFloat {
        let numberOfCells: CGFloat = 2
        let totalSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0
        let availableWidth = collectionView.bounds.width - (numberOfCells - 1) * totalSpacing
        return (availableWidth / numberOfCells) - 24
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        searchBar.delegate = self
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        hideContainerView()
        configureKeyboardManager()
    }

    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 20)
    }

    private func configureKeyboardManager() {
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistance = 10
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCVNib(cell: CategoryCVCell.self)
        collectionView.registerCVNib(cell: ProudctCVCell.self)
    }

    private func hideContainerView(isHidden: Bool = false) {
        titleLabel.isHidden = isHidden
        filterButton.isHidden = !isHidden
    }

    // MARK: - Actions
    @IBAction func filterButtonCliked(_ sender: Any) {
        let vc = FiltersVC()
        vc.filterResult = { categotyList, brandList in
            self.filtterCategotyList = categotyList
            self.filtterBrandList = brandList
            self.filterProducts()
        }
        vc.filterCategoryList = self.filtterCategotyList
        vc.filterBrandList = self.filtterBrandList
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

    // MARK: - Filter and Search Logic
    private func filterProducts() {
        filtterProductList = dummyProductList.filter { product in
            let matchesSearch = searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())
            let matchesCategory = filtterCategotyList.isEmpty || filtterCategotyList.contains(product.category)
            let matchesBrand = filtterBrandList.isEmpty || filtterBrandList.contains(product.brand)
            return matchesSearch && (matchesCategory || matchesBrand)
        }
        updateUIAfterFiltering()
    }

    private func updateUIAfterFiltering() {
        handleEmptyState(filtterProductList.isEmpty)
        collectionView.reloadData()
    }

    private func handleEmptyState(_ isEmpty: Bool) {
       isEmpty ?  collectionView.displayEmptyMessage("No Product Found") : collectionView.removeEmptyMessage()
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isBeginSearch {
            let vc = ProductDetailsVC()
            vc.productDetails = filtterProductList[indexPath.row]
            presentDetail(vc)
        } else {
            let vc = SearchByCategoryVC()
            let categoryName = dummyCategoryList[indexPath.row].name
            vc.vcTitle = categoryName
            vc.productList = dummyProducts.filter { categoryName.contains($0.category) }
            presentDetail(vc)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ExploreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isBeginSearch ? filtterProductList.count : dummyCategoryList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isBeginSearch {
            let cell: ProudctCVCell = collectionView.dequeueCVCell(for: indexPath, cell: ProudctCVCell.self)!
            cell.configDummyData(filtterProductList[indexPath.row])
            return cell
        } else {
            let cell: CategoryCVCell = collectionView.dequeueCVCell(for: indexPath, cell: CategoryCVCell.self)!
            cell.configDummyData(dummyCategoryList[indexPath.row])
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExploreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = isBeginSearch ? 250 : cellWidth * 190 / 175
        return CGSize(width: cellWidth, height: height)
    }
}

// MARK: - UISearchBarDelegate
extension ExploreVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        isBeginSearch = !self.searchText.isEmpty
        filterProducts()
        hideContainerView(isHidden: isBeginSearch)
    }
}
