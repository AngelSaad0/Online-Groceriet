//
//  ValidMessage.swift
//  FashionApp
//
//  Created by Engy on 11/22/24.
//

import Foundation

public enum ValidMessage: String {
    // General
    case none = ""

    // Name Validation
    case nameEmpty = "Name is empty"
    case nameValid = "Name is not valid"

    // Email Validation
    case emailEmpty = "Email is empty"
    case emailValid = "Email is not valid"
    case checkingEmailFail = "Error checking if email not already registered"
    case emailExist = "Entered email already exists"
    case emailDoesNotExist = "Entered email does not exist"

    // Password Validation
    case passwordEmpty = "Password is empty"
    case passwordValid = "Password is not valid"
    case reTypeEmpty = "ReType password is empty"
    case reTypeValid = "ReType password is not valid"
    case passwordRetypeEqual = "Passwords are not equal"
    case passwordDoesNotMatch = "You have entered wrong password"

    // Mobile Validation
    case mobileEmpty = "Mobile is empty"
    case mobileValid = "Mobile is not valid"

    // Address Validation
    case addressEmpty = "Address is empty"
    case addressValid = "Address is not valid"
    case cityEmpty = "City is empty"
    case cityValid = "City is not valid"
    case countryEmpty = "Country is empty"
    case countryValid = "Country is not valid"

    // Terms and Conditions
    case termsConditions = "agree for term and conditions"

    // Success Messages
    case successLogin = "LoggedIn Successfully"
    case successRegister = "Registered Successfully"
    case defaultAddressUpdated = "Default address updated successfully"
    case newAddressAdded = "New address added successfully"
    case addressEdited = "Address has been edited successfully"
    case addedToWishlist = "Item successfully added to wishlist"
    case removedFromWishlist = "Item successfully removed from wishlist"
    case addedToShoppingCart = "Item successfully added to shopping cart"
    case foundInShoppingCart = "Item found in shopping cart"
    case removedFromShoppingCart = "Item successfully removed from shopping cart"
    case discountCodeApplied = "Congratulations, discount code applied"

    // Error Messages
    case encodingFail = "Error encoding customer info"
    case otpFail = "Error: Invalid OTP Code."
    case customerCreationFail = "Failed to create new customer"
    case draftsCreationFail = "Failed to create ShoppingCart or Wishlist"
    case ordersFetchingFailed = "Error happened while loading your orders"
    case addressesFetchingFailed = "Error happened while loading your addresses"
    case newSelectedAddressFailed = "Error happened while updating your default address"
    case placingOrderFailed = "Error happened while sending your order"
    case emptyOrderArray = "No order found"
    case exchangeRateFailed = "Failed to update currency setting"
    case unexpectedError = "Unexpected Error Happened"

    // Discount Code
    case discountCodeEmpty = "You have not entered a discount code"
    case discountCodeFailed = "Entered discount code is not valid"
    case otpResent = "OTP has been resent successfully!"

}
