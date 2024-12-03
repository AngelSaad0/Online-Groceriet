//
//  NetworkManager.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/1/24.
//

import Foundation

enum MovieError: LocalizedError {
    case badURL
    case badResponse
}

class NetworkManager {

    func fetchData<T: Decodable>(urlString: String, model: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw MovieError.badURL }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MovieError.badResponse }
        return try JSONDecoder().decode(model.self, from: data)
    }
//    func fetchImageData(from urlString: String) async throws -> Data {
//        guard let url = URL(string: urlString) else { throw MovieError.badURL }
//        let request = URLRequest(url: url)
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MovieError.badResponse }
//        return data
//    }
}
