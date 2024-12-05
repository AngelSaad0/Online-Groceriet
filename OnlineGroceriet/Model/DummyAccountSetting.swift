//
//  File.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/5/24.
//

import Foundation
enum DummyAccountSetting: String, CaseIterable {
    case orders = "Orders"
    case myDetails = "My Details"
    case address = "Delivery Address"
    case payment = "Payment Methods"
    case PromoCode = "Promo Code"
    case notifecations  = "Notifecations"
    case help = "Help"
    case About  = "About "
    var imageName: String{
        switch self {
        case .orders: "Orders"
        case .myDetails: "MyDetails"
        case .address: "DeliveryAddress"
        case .payment: "PaymentMethods"
        case .PromoCode: "PromoCode"
        case .notifecations: "Notifecations"
        case .help: "Help"
        case .About: "About"
        }
    }
}

