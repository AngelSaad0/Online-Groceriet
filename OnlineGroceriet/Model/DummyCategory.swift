//
//  DummyCategory.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import Foundation

struct DummyCategory: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let backgroundColorHex: String 
}
let dummyCategory: [DummyCategory] = [
    DummyCategory(name: "Fresh Fruits & Vegetables", imageName: "fruits_vegetables", backgroundColorHex: "#E8F5E9"),
    DummyCategory(name: "Cooking Oil & Ghee", imageName: "cooking_oil", backgroundColorHex: "#FFF3E0"),
    DummyCategory(name: "Meat & Fish", imageName: "meat_fish", backgroundColorHex: "#FFEBEE"),
    DummyCategory(name: "Bakery & Snacks", imageName: "bakery_snacks", backgroundColorHex: "#F3E5F5"),
    DummyCategory(name: "Dairy & Eggs", imageName: "dairy_eggs", backgroundColorHex: "#FFF9E1"),
    DummyCategory(name: "Beverages", imageName: "beverages", backgroundColorHex: "#E3F2FD"),
]
