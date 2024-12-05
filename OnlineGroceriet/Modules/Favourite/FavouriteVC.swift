//
//  FavouriteVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class FavouriteVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addAllToCartButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    private let favoriteManager = FavoritesManager.shared
    private let cartManager = CartManager.shared
    private var favoriteList: [DummyProduct] = [] {
        didSet {
            handleEmptyData()
        }
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteData()
        tableView.reloadData()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupTableView()
        setupLabels()
        setupButtons()
    }

    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 20)
    }

    private func setupButtons() {
        addAllToCartButton.setCustomFont(size: 18)
        addAllToCartButton.addCornerRadius(20)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerTVNib(cell: FavouriteTVCell.self)
    }

    // MARK: - Data Fetching
    private func fetchFavoriteData() {
        favoriteList = favoriteManager.fetchFavoriteItems()
        tableView.reloadData()
    }

    private func handleEmptyData() {
        let isEmpty = favoriteList.isEmpty
        addAllToCartButton.isEnabled = !isEmpty
        deleteButton.isEnabled = !isEmpty
        addAllToCartButton.backgroundColor = isEmpty ? ._7_C_7_C_7_C : ._53_B_175
        isEmpty ? tableView.displayEmptyMessage("No Items in Favourite") : tableView.removeEmptyMessage()
    }

    // MARK: - Actions
    @IBAction func addAllToCartButtonClicked(_ sender: UIButton) {
        displayMessage(massage: .addedToShoppingCart, isError: false)
        favoriteList.forEach { product in
            cartManager.addProduct(productId: product.id, quantity: 1)
        }
    }

    @IBAction func clearAllButtonClicked(_ sender: UIButton) {
        showAlert(
            title: "Clear All",
            message: "Are you sure you want to clear your Favourite list?",
            okTitle: "Yes",
            cancelTitle: "No",
            okStyle: .destructive,
            cancelStyle: .cancel,
            okHandler: { [weak self] _ in
                self?.favoriteManager.removeAllProduct()
                self?.favoriteList = []
                self?.tableView.reloadData()
                displayMessage(massage: .removedAllFromWishlist, isError: false)
            }
        )
    }

    private func removeItem(at index: Int) {
        guard index < favoriteList.count else { return }
        favoriteManager.removeProduct(productId: favoriteList[index].id)
        favoriteList.remove(at: index)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension FavouriteVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ProductDetailsVC()
        vc.productDetails = favoriteList[indexPath.row]
        presentDetail(vc)
    }
}

// MARK: - UITableViewDataSource
extension FavouriteVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < favoriteList.count else { return UITableViewCell() }
        let cell: FavouriteTVCell = tableView.dequeueTVCell(index: indexPath, cell: FavouriteTVCell.self)
        cell.config(favoriteList[indexPath.row])
        return cell
    }
}
