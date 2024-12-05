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
        titleLabel.setCustomFont(font: .gilroyBold,size: 20)
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
    private func hideContainerView(isHidden:Bool = false) {
        titleLabel.isHidden = isHidden
        filterButton.isHidden = !isHidden
    }
    // MARK: - Actions
    @IBAction func filterButtonCliked(_ sender: Any) {
        let vc = FiltersVC()
        vc.filterResult = { categotyList , brandList in
            self.filtterCategotyList = categotyList
            self.filtterBrandList = brandList
            self.handelFillter()
        }
        vc.filterCategoryList = self.filtterCategotyList
        vc.filterBrandList = self.filtterBrandList
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    private func handleEmptyCollectionView () {
        if filtterProductList.isEmpty && isBeginSearch {
            collectionView.displayEmptyMessage("No Product Found")
        }else {
            collectionView.removeEmptyMessage()
        }
    }

    private func handelFillter() {
        filtterProductList = dummyProductList
        if !searchText.isEmpty {
            filtterProductList = dummyProductList.filter{$0.name.lowercased().contains(searchText.lowercased())}
        }
        if !filtterCategotyList.isEmpty ||  !filtterBrandList.isEmpty {
            filtterProductList = self.filtterProductList.filter{
                filtterCategotyList.contains($0.category) || filtterBrandList.contains($0.brand)
            }
        }
        handleEmptyCollectionView()
        collectionView.reloadData()
    }
}
// MARK: - UICollectionViewDelegate
extension ExploreVC: UICollectionViewDelegate {

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
        }else {
            let cell: CategoryCVCell = collectionView.dequeueCVCell(for: indexPath, cell: CategoryCVCell.self)!
            cell.configDummyData(dummyCategoryList[indexPath.row])
            return cell
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ExploreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellInRow: CGFloat = 2
        if let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let collectionViewWidth = collectionView.bounds.width
            let spacingBetweenCell = flowlayout.minimumLineSpacing*(numberOfCellInRow-1)
            let adjustWidth = collectionViewWidth-spacingBetweenCell
            let width = adjustWidth/numberOfCellInRow
            let height:CGFloat = isBeginSearch ? 250 : width*190/175
            return CGSize(width: width-24, height: height)
        }
        return .zero
    }
}
// MARK: - UITextFieldDelegate
extension ExploreVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isBeginSearch = !searchText.isEmpty
        self.searchText = searchText
        handelFillter()
        hideContainerView(isHidden: isBeginSearch)

    }
}
