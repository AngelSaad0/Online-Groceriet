//
//  SearchByCategoryVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/5/24.
//

import UIKit

class SearchByCategoryVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var vcTitle: String?
    var productList:[DummyProduct] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        handelEmptyList()
    }
    // MARK: - Setup Methods
    private func setupUI() {
        titleLabel.setCustomFont(font: .gilroyBold,size: 20)
        titleLabel.text = vcTitle
    }

    // MARK: - Setup CollectionView()
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.registerCVNib(cell: ProudctCVCell.self)
    }
    private func handelEmptyList() {
        if productList.isEmpty {
            collectionView.displayEmptyMessage("No Product Available Now")
        }
        else {
            collectionView.removeEmptyMessage()
        }
    }

    @IBAction func backButtonCliked(_ sender: Any) {
        dismissDetail()
    }
}
// MARK: - UICollectionViewDelegate
extension SearchByCategoryVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsVC()
        vc.productDetails = productList[indexPath.row]
        presentDetail(vc)
    }
}
// MARK: - UICollectionViewDelegate
extension SearchByCategoryVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ProudctCVCell = collectionView.dequeueCVCell(for: indexPath, cell: ProudctCVCell.self)!
        cell.configDummyData(productList[indexPath.row])
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension SearchByCategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellInRow: CGFloat = 2
        if let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let collectionViewWidth = collectionView.bounds.width
            let spacingBetweenCell = flowlayout.minimumLineSpacing*(numberOfCellInRow-1)
            let adjustWidth = collectionViewWidth-spacingBetweenCell
            let width = adjustWidth/numberOfCellInRow
            let height:CGFloat =  250
            return CGSize(width: width-24, height: height)
        }
        return .zero
    }
}

