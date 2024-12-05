//
//  HomeVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class HomeVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var captionLabels: [UILabel]!
    @IBOutlet private var seeAllButtons: [UIButton]!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var offerCollectionView: UICollectionView!
    @IBOutlet weak var exclusiveOfferCollectionView: UICollectionView!
    @IBOutlet weak var bestSellingCollectionView: UICollectionView!
    @IBOutlet weak var GroceriesCategoryCollectionView: UICollectionView!
    @IBOutlet weak var GroceriesCollectionView: UICollectionView!
    @IBOutlet private weak var adSlideshowPageControl: UIPageControl!

    // MARK: - Properties
    let userDefaults = UserDefaultsManager.shared
    private var currentPage = 0
    private var timer: Timer?
    let offersList = ["add1","add2","add3","add4"]
    let exclusiveOfferList = dummyProducts
    let bestSellingList = Array(dummyProducts.reversed())
    let groceriesCategory = dummyCategory
    let groceriesList = dummyProducts.shuffled()
    lazy var cvs = [offerCollectionView, exclusiveOfferCollectionView, bestSellingCollectionView, GroceriesCategoryCollectionView, GroceriesCollectionView]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionViews()
        configureAdsPageControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cvs.forEach { $0?.reloadData() }
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
    }

    private func setupLabels() {
        addressLabel.setCustomFont(size: 18)
        addressLabel.text = "\(userDefaults.zone), \(userDefaults.area)"
        captionLabels.forEach { $0.setCustomFont(font: .gilroyBold, size: 30) }
    }

    private func setupButtons() {
        seeAllButtons.forEach { $0.setCustomFont(size: 16) }
    }

    private func setupCollectionViews() {
        cvs.forEach { collectionView in
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }

        let cellTypes: [(UICollectionView?, AnyClass)] = [
            (offerCollectionView, ImageDetailsCVCell.self),
            (exclusiveOfferCollectionView, ProudctCVCell.self),
            (bestSellingCollectionView, ProudctCVCell.self),
            (GroceriesCategoryCollectionView, GroceriesCategoryCVCell.self),
            (GroceriesCollectionView, ProudctCVCell.self)
        ]

        // Registering NIBs for each collection view
        cellTypes.forEach { (collectionView, cellClass) in
            if let collectionView = collectionView {
                collectionView.register(UINib(nibName: String(describing: cellClass), bundle: nil), forCellWithReuseIdentifier: String(describing: cellClass))
            }
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateAdsScroll), userInfo: nil, repeats: true)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func updateAdsScroll() {
        let nextPage = (currentPage < offersList.count - 1) ? currentPage + 1 : 0
        offerCollectionView.scrollToItem(at: IndexPath(item: nextPage, section: 0), at: .centeredHorizontally, animated: true)
    }

    private func configureAdsPageControl() {
        adSlideshowPageControl.numberOfPages = offersList.count
    }

    func pushProductDetailsVC(_ productDetails: DummyProduct) {
        let vc = ProductDetailsVC()
        vc.productDetails = productDetails
        presentDetail(vc)
    }

    func pushCategoryDetailsVC(_ categoryName: String) {
        let vc = SearchByCategoryVC()
        vc.productList = dummyProducts.filter { categoryName.contains($0.category) }
        vc.vcTitle = categoryName
        presentDetail(vc)
    }

    // MARK: - Actions
    @IBAction func seeAllButtonCliked(_ sender: UIButton) {
        let vc = SearchByCategoryVC()
        switch sender.tag {
        case 0:
            vc.vcTitle = "Exclusive Offer"
            vc.productList = exclusiveOfferList
        case 1:
            vc.vcTitle = "Best Selling"
            vc.productList = bestSellingList
        case 2:
            vc.vcTitle = "Groceries"
            vc.productList = groceriesList
        default: break
        }
        presentDetail(vc)
    }

    @IBAction func addressButtonCliked(_ sender: Any) {
        presentDetail(SelectLocationVC())
    }

    @IBAction func searchButtonCliked(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
}

// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == offerCollectionView {
            currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
            adSlideshowPageControl.currentPage = currentPage
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case offerCollectionView: break
        case exclusiveOfferCollectionView: pushProductDetailsVC(exclusiveOfferList[indexPath.row])
        case bestSellingCollectionView: pushProductDetailsVC(bestSellingList[indexPath.row])
        case GroceriesCollectionView: pushProductDetailsVC(groceriesList[indexPath.row])
        case GroceriesCategoryCollectionView: pushCategoryDetailsVC(groceriesCategory[indexPath.row].name)
        default: break
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case offerCollectionView: return offersList.count
        case exclusiveOfferCollectionView: return exclusiveOfferList.count
        case bestSellingCollectionView: return bestSellingList.count
        case GroceriesCategoryCollectionView: return groceriesCategory.count
        case GroceriesCollectionView: return groceriesList.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case offerCollectionView:
            let cell: ImageDetailsCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageDetailsCVCell.self), for: indexPath) as! ImageDetailsCVCell
            cell.image.contentMode = .scaleAspectFill
            cell.image.image = UIImage(named: offersList[indexPath.row])
            return cell

        case exclusiveOfferCollectionView:
            let cell: ProudctCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProudctCVCell.self), for: indexPath) as! ProudctCVCell
            cell.configDummyData(exclusiveOfferList[indexPath.row])
            return cell

        case bestSellingCollectionView:
            let cell: ProudctCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProudctCVCell.self), for: indexPath) as! ProudctCVCell
            cell.configDummyData(bestSellingList[indexPath.row])
            return cell

        case GroceriesCategoryCollectionView:
            let cell: GroceriesCategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GroceriesCategoryCVCell.self), for: indexPath) as! GroceriesCategoryCVCell
            cell.configDummyData(groceriesCategory[indexPath.row])
            return cell

        case GroceriesCollectionView:
            let cell: ProudctCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProudctCVCell.self), for: indexPath) as! ProudctCVCell
            cell.configDummyData(groceriesList[indexPath.row])
            return cell

        default: return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case offerCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case exclusiveOfferCollectionView:
            return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
        case bestSellingCollectionView:
            return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
        case GroceriesCategoryCollectionView:
            return CGSize(width: collectionView.frame.width / 1.5, height: collectionView.frame.height)
        case GroceriesCollectionView:
            return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
        default:
            return .zero
        }
    }
}
