//
//  ProductDetailsVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/3/24.
//

import UIKit

class ProductDetailsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var subDetailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet  var subTitleLabels: [UILabel]!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    // MARK: - Properties
    var productDetails: DummyProduct!
    var dummyProductImageList: [String] = []
    private var currentPage = 0
    private var timer: Timer?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        producImageDummyData()
        setupUI()
        configureAdsPageControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupButtons()
        setupContainerView()
        setupCollectionView()
        updateDetails()
    }
    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 26)
        priceLabel.setCustomFont(font: .gilroyBold, size: 24)
        subTitleLabels.forEach{$0.setCustomFont(font: .gilroyMedium,size: 16)}
        detailsLabel.setCustomFont(size: 16)
        subDetailsLabel.setCustomFont(font: .gilroyMedium, size: 13)
        quantityLabel.setCustomFont(size: 9)
    }

    private func setupButtons() {
        addToCartButton.setCustomFont(size: 18)
        addToCartButton.addCornerRadius(20)
    }

    private func setupContainerView() {
        containerView.addCornerRadius(corners: [.layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 20)
    }

    private func updateDetails() {
        detailsLabel.text = "\(productDetails.quantity), Price"
        subDetailsLabel.text = productDetails.productDetail
        quantityLabel.text =  productDetails.nutritionsPerAmount
        priceLabel.text = "$ \(productDetails.price)"
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCVNib(cell: ImageDetailsCVCell.self)
    }

    private func producImageDummyData() {
        dummyProductImageList = Array(repeating: productDetails.imageName, count: 4)
    }
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateAdsScroll), userInfo: nil, repeats: true)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func updateAdsScroll() {
        let nextPage = (currentPage < dummyProductImageList.count - 1) ? currentPage + 1 : 0
        collectionView.scrollToItem(at: IndexPath(item: nextPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    private func configureAdsPageControl() {
        pageControl.numberOfPages = dummyProductImageList.count
    }
    func pushProductDetailsVC(_ productDetails: DummyProduct) {
        let vc = ProductDetailsVC()
        vc.productDetails = productDetails
        presentDetail(vc)
    }

    // MARK: - Actions
    @IBAction func shareButtonClicked(_ sender: Any) {
    }
    @IBAction func dismissButtonClicked(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func addToCartButtonClicked(_ sender: Any) {
    }


}
extension ProductDetailsVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }

}
extension ProductDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dummyProductImageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageDetailsCVCell = collectionView.dequeueCVCell(for: indexPath, cell: ImageDetailsCVCell.self)!
        cell.image.image = UIImage(named: dummyProductImageList[indexPath.row])
        return cell
    }

}
extension ProductDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-80, height: collectionView.frame.height)
    }
}
