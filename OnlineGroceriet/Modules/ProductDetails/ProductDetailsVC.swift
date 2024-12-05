//
//  ProductDetailsVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/3/24.
//

//
//  ProductDetailsVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/3/24.
//

import UIKit
import Cosmos

class ProductDetailsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var subDetailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var collectionContainerView: UIView!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nutritionsDetailView: UIStackView!
    @IBOutlet var subTitleLabels: [UILabel]!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet weak var addToFavorteButton: UIButton!
    @IBOutlet weak var starRatingView: CosmosView!

    // MARK: - Properties
    var productDetails: DummyProduct!
    var dummyProductImageList: [String] = []
    var isFavorite: Bool = false {
        didSet {
            updateFavoriteButtonImage()
            updateCoreData()
        }
    }
    let cartManager = CartManager.shared
    let favorteManager = FavoritesManager.shared
    private var currentPage = 0
    private var timer: Timer?
    private var productQuantity = 1 {
        didSet {
            itemCountLabel.text = "\(productQuantity)"
            updateButtonState()
            updatePrice()
        }
    }
    lazy var nutritionView = NutritionsDetailView(frame: .zero)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        producImageDummyData()
        setupUI()
        configureAdsPageControl()
        setupStarRatingView()
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
        checkFavoriteState()
        setupCollectionView()
        updateDetails()
    }

    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 26)
        priceLabel.setCustomFont(font: .gilroyBold, size: 24)
        subTitleLabels.forEach { $0.setCustomFont(font: .gilroyMedium, size: 16) }
        detailsLabel.setCustomFont(size: 16)
        subDetailsLabel.setCustomFont(font: .gilroyMedium, size: 16)
        quantityLabel.setCustomFont(size: 9)
        itemCountLabel.setCustomFont(size: 18)
    }

    private func checkFavoriteState() {
        isFavorite = favorteManager.isProductInFavorites(productId: productDetails.id)
    }

    private func setupButtons() {
        addToCartButton.setCustomFont(size: 18)
        addToCartButton.addCornerRadius(20)
    }

    private func setupContainerView() {
        collectionContainerView.addCornerRadius(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 30)
        labelContainerView.addCornerRadius(17)
        labelContainerView.addBorder(color: .F_2_F_3_F_2, width: 2)
        quantityView.addCornerRadius(8)
    }

    private func updateDetails() {
        detailsLabel.text = "\(productDetails.quantity), Price"
        subDetailsLabel.text = productDetails.productDetail
        quantityLabel.text = productDetails.nutritionsPerAmount
        priceLabel.text = "$ \(productDetails.price)"
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCVNib(cell: ImageDetailsCVCell.self)
    }

    private func producImageDummyData() {
        let image = productDetails.imageName
        dummyProductImageList = [image, "details2", image, "details1"]
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

    private func updateButtonState() {
        plusButton.setImage(UIImage(named: productQuantity == 5 ? "plusUnActive" : "plusActive"), for: .normal)
        minusButton.setImage(UIImage(named: productQuantity == 1 ? "minusUnActive" : "minusActive"), for: .normal)
    }

    private func updatePrice() {
        priceLabel.text = "$ \(productDetails.price * Double(productQuantity))"
    }

    private func updateFavoriteButtonImage() {
        let image = UIImage(named: isFavorite ? "heart.fill" : "heart")
        addToFavorteButton.setImage(image, for: .normal)
    }

    private func saveData() {
        cartManager.addProduct(productId: productDetails.id, quantity: productQuantity)
    }

    private func updateCoreData() {
        if isFavorite {
            if !favorteManager.isProductInFavorites(productId: productDetails.id) {
                favorteManager.addProduct(productId: productDetails.id)
            }
        } else {
            favorteManager.removeProduct(productId: productDetails.id)
        }
    }
    private func setupStarRatingView() {
        starRatingView.contentMode = .right
        starRatingView.settings.totalStars = 5
        starRatingView.settings.fillMode = .precise
        starRatingView.settings.filledImage = .star
        starRatingView.rating = Double(productDetails.review) ?? 1
        starRatingView.isUserInteractionEnabled = false
        starRatingView.settings.filledColor = .F_3603_F
        starRatingView.settings.emptyBorderColor = .gray
        starRatingView.settings.filledBorderColor = .yellow
    }

    // MARK: - Actions
    @IBAction func shareButtonClicked(_ sender: Any) {}

    @IBAction func dismissButtonClicked(_ sender: Any) {
        dismissDetail()
    }

    @IBAction func addToCartButtonClicked(_ sender: Any) {
        displayMessage(massage: .addedToShoppingCart, isError: false)
        saveData()
    }

    @IBAction func nutritionsDetailButtonClicked(_ sender: Any) {
        scrollView.addSubview(nutritionView)
        nutritionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nutritionView.topAnchor.constraint(equalTo: nutritionsDetailView.topAnchor),
            nutritionView.bottomAnchor.constraint(equalTo: nutritionsDetailView.bottomAnchor),
            nutritionView.leadingAnchor.constraint(equalTo: nutritionsDetailView.leadingAnchor),
            nutritionView.trailingAnchor.constraint(equalTo: nutritionsDetailView.trailingAnchor),
        ])
        nutritionView.handelAction = {
            self.nutritionView.removeFromSuperview()
        }
        nutritionView.textLabel.text = productDetails.nutritionsDetail
    }

    @IBAction func toggleProductDetails(_ sender: UIButton) {
        UIView.transition(with: subDetailsLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.subDetailsLabel.isHidden = !self.subDetailsLabel.isHidden
        }, completion: nil)
        let buttonImage = subDetailsLabel.isHidden ? "arrowDown2" : "arrowUp"
        sender.setImage(UIImage(named: buttonImage), for: .normal)
    }

    @IBAction func addToFavorite(_ sender: UIButton) {
        isFavorite.toggle()
    }

    @IBAction func plusButtonClicked(_ sender: UIButton) {
        if productQuantity < 5 {
            productQuantity += 1
        }
    }

    @IBAction func minusButtonClicked(_ sender: Any) {
        if productQuantity > 1 {
            productQuantity -= 1
        }
    }

    @IBAction func ratingButtonClicked(_ sender: Any) {
        starRatingView.isHidden = !starRatingView.isHidden
    }
}

extension ProductDetailsVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = currentPage
        }
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
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
