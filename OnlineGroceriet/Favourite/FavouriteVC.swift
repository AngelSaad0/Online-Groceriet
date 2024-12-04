//
//  FavouriteVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class FavouriteVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addAllToCartButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    let favoriteManger = FavoritesManager.shared
    let cartManger = CartManager.shared
    var favoriteList :[DummyProduct] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
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

    @IBAction func addAllToCartButtonCliked(_ sender: Any) {
        favoriteList.forEach { product in
            cartManger.addProduct(productId: product.id , quantity: 1)
        }
    }

}
extension FavouriteVC: UITableViewDelegate {
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
