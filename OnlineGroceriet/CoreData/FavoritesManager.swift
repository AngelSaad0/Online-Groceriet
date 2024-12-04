//
//  FavoritesManager.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/4/24.
//

import Foundation
import CoreData

class FavoritesManager {
    static let shared = FavoritesManager()
    private let managedContext = CoreDataManager.shared.managedContext

    private init() {}

    func addProduct(productId: Int) {
        if !isProductInFavorites(productId: productId) {
            let favoriteItem = FavoriteItem(context: managedContext)
            favoriteItem.id = Int64(productId)
            CoreDataManager.shared.saveContext()
            print("Product added to favorites successfully.")
        } else {
            print("Product already exists in favorites.")
        }
    }

    func fetchFavoriteItems() -> [DummyProduct] {
        let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()

        do {
            let results = try managedContext.fetch(fetchRequest)
            return mapFavoritesToProducts(items: results)
        } catch {
            print("Error fetching favorite items: \(error)")
            return []
        }
    }

    private func mapFavoritesToProducts(items: [FavoriteItem]) -> [DummyProduct] {
        var products: [DummyProduct] = []
        for item in items {
            if let product = dummyProducts.first(where: { $0.id == item.id }) {
                products.append(product)
            }
        }
        return products
    }

    /// Removes a product from favorites.
    func removeProduct(productId: Int) {
        let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", productId)

        do {
            let results = try managedContext.fetch(fetchRequest)
            results.forEach { managedContext.delete($0) }
            CoreDataManager.shared.saveContext()
            print("Product removed from favorites successfully.")
        } catch {
            print("Error removing product from favorites: \(error)")
        }
    }

    /// Checks if a product exists in favorites.
     func isProductInFavorites(productId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", productId)

        do {
            return try managedContext.count(for: fetchRequest) > 0
        } catch {
            print("Error checking product existence in favorites: \(error)")
            return false
        }
    }
}

