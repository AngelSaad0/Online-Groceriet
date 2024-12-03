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
    DummyCategory(name: "Fresh Fruits & Vegetables", imageName: "3", backgroundColorHex: "#E8F5E9"),
    DummyCategory(name: "Cooking Oil & Ghee", imageName: "pngfuel", backgroundColorHex: "#FFF3E0"),
    DummyCategory(name: "Meat & Fish", imageName: "7", backgroundColorHex: "#FFEBEE"),
    DummyCategory(name: "Bakery & Snacks", imageName: "pngfuel 6-1", backgroundColorHex: "#F3E5F5"),
    DummyCategory(name: "Dairy & Eggs", imageName: "pngfuel 16", backgroundColorHex: "#FFF9E1"),
    DummyCategory(name: "Beverages", imageName: "8", backgroundColorHex: "#E3F2FD")
]

