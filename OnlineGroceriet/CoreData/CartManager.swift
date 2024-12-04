//
//  CartManager.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/4/24.
//

import Foundation
import CoreData

class CartManager {
    static let shared = CartManager()
    private let managedContext = CoreDataManager.shared.managedContext

    private init() {}

    /// Adds a product to the cart if it does not already exist.
    func addProduct(productId: Int, quantity: Int) {
        if !isProductInCart(productId: productId) {
            let cartItem = CartItem(context: managedContext)
            cartItem.id = Int64(productId)
            cartItem.quantity = Int64(quantity)
            CoreDataManager.shared.saveContext()
            print("Product added to cart successfully.")
        } else {
            print("Product already exists in the cart.")
        }
    }

    /// Fetches all items in the cart.
    func fetchCartItems() -> ([DummyProduct], [Int]) {
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()

        do {
            let results = try managedContext.fetch(fetchRequest)
            return mapCartItemsToProducts(items: results)
        } catch {
            print("Error fetching cart items: \(error)")
            return ([], [])
        }
    }

    /// Maps CartItem entities to DummyProduct objects and quantities.
    private func mapCartItemsToProducts(items: [CartItem]) -> ([DummyProduct], [Int]) {
        var products: [DummyProduct] = []
        var quantities: [Int] = []
        for item in items {
            if let product = dummyProducts.first(where: { $0.id == item.id }) {
                products.append(product)
                quantities.append(Int(item.quantity))
            }
        }
        return (products, quantities)
    }

    /// Removes a product from the cart.
    func removeProduct(productId: Int) {
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", productId)

        do {
            let results = try managedContext.fetch(fetchRequest)
            results.forEach { managedContext.delete($0) }
            CoreDataManager.shared.saveContext()
            print("Product removed from cart successfully.")
        } catch {
            print("Error removing product from cart: \(error)")
        }
    }

    /// Checks if a product exists in the cart.
    private func isProductInCart(productId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", productId)

        do {
            return try managedContext.count(for: fetchRequest) > 0
        } catch {
            print("Error checking product existence in cart: \(error)")
            return false
        }
    }
    /// Updates the quantity of a product in the cart.
    func updateProductQuantity(productId: Int, quantity: Int) {
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", productId)

        do {
            if let cartItem = try managedContext.fetch(fetchRequest).first {
                cartItem.quantity = Int64(quantity)
                CoreDataManager.shared.saveContext()
                print("Product quantity updated successfully.")
            } else {
                print("Product not found in the cart.")
            }
        } catch {
            print("Error updating product quantity: \(error)")
        }
    }

}

