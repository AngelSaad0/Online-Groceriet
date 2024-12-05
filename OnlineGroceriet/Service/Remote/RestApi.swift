//
//  RestApi.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//
import Foundation
enum APIHelper {
    static let baseURL = "https://restcountries.com/v3.1"


    case allCountries
    case user(userID: Int)
    case albums(userID: Int)
    case photos(userID: Int, albumID: Int)
    var path: String {
        switch self {
        case .allCountries:
            return APIHelper.baseURL + "/all"
        case .user(let userID):
            return APIHelper.baseURL + "/users/\(userID)"
        case .albums(let userID):
            return APIHelper.baseURL + "/users/\(userID)/albums"
        case.photos(let userID, let albumID):
            return APIHelper.baseURL + "/users/\(userID)/photos?albumId=\(albumID)"
        }
    }
}
