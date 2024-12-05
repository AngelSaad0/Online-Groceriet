//
//  CartVC.swiftFavouriteVC
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

//
//  CartVC.swift
//  OnlineGroceries
//
//  Created by Engy on 12/1/24.
//

import UIKit

class CartVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var checkOutButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var priceLabelContainer: UIView!

    // MARK: - Properties
    private let cartManager = CartManager.shared
    private typealias CartData = ([DummyProduct], [Int])
    private var cartList: CartData = ([], []) {
        didSet {
            handleEmptyData()
        }
    }
    private var totalPrice: Double = 0.0 {
        didSet {
            totalPriceLabel.text = String(format: "$%.2f", totalPrice)
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshCartData()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupButtons()
        setupContainerView()
        setupTableView()
        refreshCartData()
    }

    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 20)
        totalPriceLabel.setCustomFont(size: 12)
    }

    private func setupButtons() {
        checkOutButton.setCustomFont(size: 18)
        checkOutButton.addCornerRadius(20)
    }

    private func setupContainerView() {
        priceLabelContainer.addCornerRadius(8)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerTVNib(cell: CartTVCell.self)
    }

    // MARK: - Helper Methods
    private func refreshCartData() {
        cartList = cartManager.fetchCartItems()
        calculateTotalPrice()
        tableView.reloadData()
    }

    private func calculateTotalPrice() {
        totalPrice = zip(cartList.0, cartList.1)
            .reduce(0) { $0 + ($1.0.price * Double($1.1)) }
    }

    private func updateTotalPrice(by priceDifference: Double) {
        totalPrice += priceDifference
    }

    private func handleEmptyData() {
        let isEmpty = cartList.0.isEmpty
        priceLabelContainer.isHidden = isEmpty
        checkOutButton.isEnabled = !isEmpty
        checkOutButton.backgroundColor = isEmpty ? ._7_C_7_C_7_C : ._53_B_175
        isEmpty ? tableView.displayEmptyMessage("No Items in Cart") : tableView.removeEmptyMessage()
    }

    private func removeItem(at index: Int) {
        guard index < cartList.0.count else { return }
        cartManager.removeProduct(productId: cartList.0[index].id)
        cartList.0.remove(at: index)
        cartList.1.remove(at: index)
        calculateTotalPrice()
        tableView.reloadData()
    }

    // MARK: - Actions
    @IBAction private func checkButtonClicked(_ sender: Any) {
        let vc = CheckoutVC()
        vc.totalCost = totalPrice
        if let presentationController = vc.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
        }
        present(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ProductDetailsVC()
        vc.productDetails = cartList.0[indexPath.row]
        presentDetail(vc)
    }
}

// MARK: - UITableViewDataSource
extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 157
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.0.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTVCell = tableView.dequeueTVCell(index: indexPath, cell: CartTVCell.self)
        let product = cartList.0[indexPath.row]
        let quantity = cartList.1[indexPath.row]
        cell.config(product: product, quantity: quantity)

        // Delegation for better communication
        cell.onItemCountChange = { [weak self] priceDifference in
            self?.updateTotalPrice(by: priceDifference)
        }
        cell.deleteButtonClicked = { [weak self] in
            self?.removeItem(at: indexPath.row)
        }

        return cell
    }
}
