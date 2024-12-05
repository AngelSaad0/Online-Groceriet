//
//  FavouriteVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class FavouriteVC: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addAllToCartButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let favoriteManger = FavoritesManager.shared
    let cartManger = CartManager.shared
    var favoriteList :[DummyProduct] = [] {
        didSet {
            handleEmptyData()
        }
    }
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
        fetchFavoriteData()
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

    private func fetchFavoriteData() {
        favoriteList = favoriteManger.fetchFavoriteItems()
    }
    // MARK: - Setup TableView()
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerTVNib(cell: FavouriteTVCell.self)
    }
    private func  handleEmptyData() {
        let isEmptyList = favoriteList.isEmpty

        addAllToCartButton.isEnabled = !isEmptyList
        deleteButton.isEnabled = !isEmptyList
        addAllToCartButton.backgroundColor = isEmptyList ? ._7_C_7_C_7_C : ._53_B_175
        isEmptyList ? tableView.displayEmptyMessage("No Item In Favorurite") : tableView.removeEmptyMessage()

    }
    private func removeItem(at index: Int) {
        favoriteManger.removeProduct(productId: favoriteList[index].id)
        favoriteList.remove(at: index)
           tableView.reloadData()
       }
    @IBAction func addAllToCartButtonCliked(_ sender: Any) {
        displayMessage(massage: .addedToShoppingCart,isError: false)
        favoriteList.forEach { product in
            cartManger.addProduct(productId: product.id , quantity: 1)
        }
    }

    @IBAction func clearAllButtonClicked(_ sender: Any) {
        showAlert(title: "Clear All", message: "are you Sure you want to clear your Favourite list? ", okTitle:  "Yes", cancelTitle: "No", okStyle: .destructive, cancelStyle: .cancel, okHandler: { _ in
            self.favoriteManger.removeAllProduct()
            self.favoriteList = []
            self.tableView.reloadData()
            displayMessage(massage: .removedAllFromWishlist,isError: false)
        })}

}
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

extension FavouriteVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FavouriteTVCell = tableView.dequeueTVCell(index: indexPath, cell: FavouriteTVCell.self)
        cell.config(favoriteList[indexPath.row])
        return cell
    }


}
