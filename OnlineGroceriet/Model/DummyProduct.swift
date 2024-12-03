//
//  Product.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//
import Foundation

// MARK: - Product Model
struct DummyProduct {
    let name: String
    let price: Double
    let quantity: String
    let imageName: String
    let category: String
    let brand: String
    let nutritionsPerAmount: String
    let nutritionsDetail: String
    let productDetail: String
    let review: String
}
let dummyProducts: [DummyProduct] = [
    // Beverages
    DummyProduct(name: "Diet Coke", price: 1.99, quantity: "355ml", imageName: "pngfuel 11", category: "Beverages", brand: "Coca Cola", nutritionsPerAmount: "100ml", nutritionsDetail: "0 kcal, 0g fat, 0g sugar, 0g protein", productDetail: "Diet Coke is a zero-calorie, sugar-free soft drink, perfect for those watching their caloric intake.", review: "4.2"),
    DummyProduct(name: "Sprite Can", price: 1.50, quantity: "325ml", imageName: "pngfuel 12", category: "Beverages", brand: "Coca Cola", nutritionsPerAmount: "100ml", nutritionsDetail: "39 kcal, 0g fat, 9g sugar, 0g protein", productDetail: "Sprite is a refreshing lemon-lime soda known for its crisp and clean taste.", review: "3.9"),
    DummyProduct(name: "Apple & Grape Juice", price: 15.99, quantity: "2L", imageName: "pngfuel 9", category: "Beverages", brand: "FruitCo", nutritionsPerAmount: "100ml", nutritionsDetail: "45 kcal, 0g fat, 11g sugar, 0.1g protein", productDetail: "A delicious blend of apple and grape juices, perfect for a natural energy boost.", review: "4.5"),
    DummyProduct(name: "Orange Juice", price: 15.99, quantity: "2L", imageName: "8", category: "Beverages", brand: "CitrusFresh", nutritionsPerAmount: "100ml", nutritionsDetail: "50 kcal, 0g fat, 12g sugar, 1g protein", productDetail: "Freshly squeezed orange juice, packed with vitamin C for a healthy immune system.", review: "4.7"),
    DummyProduct(name: "Coca Cola Can", price: 4.99, quantity: "325ml", imageName: "pngfuel 13", category: "Beverages", brand: "Coca Cola", nutritionsPerAmount: "100ml", nutritionsDetail: "42 kcal, 0g fat, 10.6g sugar, 0g protein", productDetail: "Coca Cola, a classic soda with a bold taste loved worldwide.", review: "4.0"),
    DummyProduct(name: "Pepsi Can", price: 4.99, quantity: "330ml", imageName: "pngfuel 14", category: "Beverages", brand: "Pepsi", nutritionsPerAmount: "100ml", nutritionsDetail: "43 kcal, 0g fat, 11g sugar, 0g protein", productDetail: "Pepsi, a refreshing cola drink with a unique and rich flavor.", review: "3.8"),

    // Fruits
    DummyProduct(name: "Organic Bananas", price: 4.99, quantity: "7pcs", imageName: "2", category: "Fruits", brand: "FreshFruits", nutritionsPerAmount: "100g", nutritionsDetail: "89 kcal, 0.3g fat, 23g carbs, 1.1g protein", productDetail: "Organic bananas are a natural source of potassium, providing energy and supporting heart health.", review: "4.6"),
    DummyProduct(name: "Red Apple", price: 4.99, quantity: "1kg", imageName: "5", category: "Fruits", brand: "OrchardFresh", nutritionsPerAmount: "100g", nutritionsDetail: "52 kcal, 0.2g fat, 14g carbs, 0.3g protein", productDetail: "Apples are nutritious and may support weight loss and heart health as part of a balanced diet.", review: "4.3"),
    DummyProduct(name: "Green Grapes", price: 3.99, quantity: "500g", imageName: "4", category: "Fruits", brand: "GrapeCo", nutritionsPerAmount: "100g", nutritionsDetail: "69 kcal, 0.2g fat, 18g carbs, 0.6g protein", productDetail: "Green grapes are sweet and juicy, packed with antioxidants and vitamins.", review: "4.1"),
    DummyProduct(name: "Watermelon", price: 6.99, quantity: "1pc", imageName: "pngfuel 6-2", category: "Fruits", brand: "FreshFruits", nutritionsPerAmount: "100g", nutritionsDetail: "30 kcal, 0.2g fat, 8g carbs, 0.6g protein", productDetail: "Watermelon is hydrating and refreshing, perfect for hot summer days.", review: "4.8"),

    // Vegetables
    DummyProduct(name: "Fresh Carrots", price: 2.99, quantity: "1kg", imageName: "3", category: "Vegetables", brand: "GreenHarvest", nutritionsPerAmount: "100g", nutritionsDetail: "41 kcal, 0.2g fat, 10g carbs, 0.9g protein", productDetail: "Carrots are a crunchy and sweet source of beta-carotene, good for vision and skin.", review: "4.4"),
    DummyProduct(name: "Potatoes", price: 3.49, quantity: "1kg", imageName: "pngfuel 6", category: "Vegetables", brand: "FarmFresh", nutritionsPerAmount: "100g", nutritionsDetail: "77 kcal, 0.1g fat, 17g carbs, 2g protein", productDetail: "Potatoes are versatile and provide a good source of energy and fiber.", review: "4.0"),
    DummyProduct(name: "Onions", price: 2.99, quantity: "1kg", imageName: "pngfuel 6", category: "Vegetables", brand: "GreenHarvest", nutritionsPerAmount: "100g", nutritionsDetail: "40 kcal, 0.1g fat, 9g carbs, 1.1g protein", productDetail: "Onions add flavor and aroma to dishes, rich in antioxidants.", review: "4.3"),
    DummyProduct(name: "Broccoli", price: 4.49, quantity: "500g", imageName: "2", category: "Vegetables", brand: "GreenHarvest", nutritionsPerAmount: "100g", nutritionsDetail: "55 kcal, 0.6g fat, 11g carbs, 4g protein", productDetail: "Broccoli is a superfood, high in fiber, vitamins, and minerals.", review: "4.7"),

    // Meat
    DummyProduct(name: "Beef Bone", price: 4.99, quantity: "1kg", imageName: "7", category: "Meat", brand: "Butcher's Choice", nutritionsPerAmount: "100g", nutritionsDetail: "250 kcal, 20g fat, 0g carbs, 17g protein", productDetail: "Beef bones are ideal for soups and broths, rich in collagen.", review: "4.1"),
    DummyProduct(name: "Broiler Chicken", price: 4.99, quantity: "1kg", imageName: "pngfuel 5", category: "Meat", brand: "PoultryFresh", nutritionsPerAmount: "100g", nutritionsDetail: "239 kcal, 14g fat, 0g carbs, 27g protein", productDetail: "Broiler chicken is versatile and high in protein, suitable for many recipes.", review: "4.5"),
    DummyProduct(name: "Mutton Leg", price: 8.99, quantity: "1kg", imageName: "pngfuel 6-1", category: "Meat", brand: "LambCo", nutritionsPerAmount: "100g", nutritionsDetail: "294 kcal, 23g fat, 0g carbs, 20g protein", productDetail: "Mutton leg is tender and flavorful, perfect for slow-cooked dishes.", review: "4.2"),
    DummyProduct(name: "Chicken Wings", price: 5.99, quantity: "1kg", imageName: "6", category: "Meat", brand: "PoultryFresh", nutritionsPerAmount: "100g", nutritionsDetail: "203 kcal, 13g fat, 0g carbs, 19g protein", productDetail: "Chicken wings are juicy and great for grilling or frying.", review: "4.6"),

    // Groceries
    DummyProduct(name: "Rice", price: 1.99, quantity: "1kg", imageName: "1", category: "Groceries", brand: "GrainCo", nutritionsPerAmount: "100g", nutritionsDetail: "130 kcal, 0.3g fat, 28g carbs, 2.7g protein", productDetail: "Rice is a staple food, versatile and easy to prepare.", review: "4.8"),
    DummyProduct(name: "Flour", price: 0.99, quantity: "1kg", imageName: "10", category: "Groceries", brand: "BakeCo", nutritionsPerAmount: "100g", nutritionsDetail: "364 kcal, 1g fat, 76g carbs, 10g protein", productDetail: "Flour is essential for baking and cooking, rich in carbohydrates.", review: "4.5"),
    DummyProduct(name: "Sugar", price: 1.50, quantity: "1kg", imageName: "11", category: "Groceries", brand: "SweetCo", nutritionsPerAmount: "100g", nutritionsDetail: "387 kcal, 0g fat, 100g carbs, 0g protein", productDetail: "Sugar is a sweetener used in various recipes and beverages.", review: "4.0"),
    DummyProduct(name: "Salt", price: 0.50, quantity: "1kg", imageName: "12", category: "Groceries", brand: "SpiceCo", nutritionsPerAmount: "100g", nutritionsDetail: "0 kcal, 0g fat, 0g carbs, 0g protein", productDetail: "Salt enhances flavor in dishes and is a kitchen essential.", review: "4.9")
]
