//
//  CartVC.swiftFavouriteVC
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabelContainer: UIView!
    let cartManger = CartManager.shared
    var cartList :([DummyProduct],[Int]) = ([],[])
    var totalPrice = 0.0{
        didSet {
            totalPriceLabel.text =  String(format: "$%.2f", totalPrice)
        }
    }
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
        fetchCartData()
        setupTableView()
        setupLabels()
        setupButtons()
        setupContainerView()

    }
    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyBold, size: 20)
        totalPriceLabel.setCustomFont(size: 12)
    }

    private func setupButtons() {
        checkButton.setCustomFont(size: 18)
        checkButton.addCornerRadius(20)
    }
    private func setupContainerView() {
        priceLabelContainer.addCornerRadius(8)
    }
    private func fetchCartData() {
        cartList = cartManger.fetchCartItems()
        calculateTotalPrice()
    }
    private func calculateTotalPrice() {
        totalPrice = 0
        for (product, quantity) in zip(cartList.0,cartList.1) {
            totalPrice += product.price * Double(quantity)

        }
    }
    private func updateTotalPriceByDifference(_ priceDifference: Double) {
        totalPrice += priceDifference
    }

    // MARK: - Setup TableView()
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerTVNib(cell: CartTVCell.self)
    }
    private func removeItem(at index: Int) {
        cartManger.removeProduct(productId: cartList.0[index].id)
           cartList.0.remove(at: index)
           cartList.1.remove(at: index)
           tableView.reloadData()
           calculateTotalPrice()
       }

    @IBAction func checkButtonCliked(_ sender: Any) {

    }


}
extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = ProductDetailsVC()
//        vc.productDetails = cartList[indexPath.row]
//        presentDetail(vc)
    }
}

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 157
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartList.0.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CartTVCell = tableView.dequeueTVCell(index: indexPath, cell: CartTVCell.self)
        let product = cartList.0[indexPath.row]
        let quantity = cartList.1[indexPath.row]
        cell.config(product: product, quantity: quantity)
        cell.onItemCountChange = { priceDifference in
            self.updateTotalPriceByDifference(priceDifference)
        }
        cell.deleteButtonClicked = { [weak self] in
         self?.removeItem(at: indexPath.row)
        }
        return cell
    }
    

}
