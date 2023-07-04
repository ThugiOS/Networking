//
//  NetworkServiceWithAsync.swift
//  Networking
//
//  Created by Никитин Артем on 4.07.23.
//

import Foundation

class NetworkServiceWithAsync {
    // 1. создали синглтон
    static let shared = NetworkServiceWithAsync(); private init() { }
    
    // 2. создали УРЛ
    private func createURL() -> URL? {
        let tunnel = "https://"
        let server = "randomuser.me"
        let endpoint = "/api"
        let getParams = ""
        let urlStr = tunnel + server + endpoint + getParams
        
        let url = URL(string: urlStr)
        return url
    }
    
    // 3. получили данные и распарсили
    func fetchData() async throws -> UserResaults {
        guard let url = createURL() else { throw NetworkingError.badUrl }
        
        let response = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let result = try decoder.decode(UserResaults.self, from: response.0) // 0 - data, 1 - response
        
        return result
    }
}

//enum NetworkingError: Error {
//    case badUrl, invalidData
//}
