//
//  NetworkServiseWithAlamofire.swift
//  Networking
//
//  Created by Никитин Артем on 4.07.23.
//

import Foundation
import Alamofire

class NetworkServiseWithAlamofire {
    static let shared = NetworkServiseWithAlamofire(); private init() { }
    
    private func createURL() -> String {
        let tunnel = "https://"
        let server = "randomuser.me"
        let endpoint = "/api"
        let getParams = ""
        let urlStr = tunnel + server + endpoint + getParams
        
        return urlStr
    }
    
    func fetchData(completion: @escaping (Result<UserResaults, Error>) -> ()) {
        AF.request(createURL())
            .validate()
            .response { response in // response = data, response, error
            guard let data = response.data else {
                if let error = response.error {
                    completion(.failure(error))
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let userResults = try? decoder.decode(UserResaults.self, from: data) else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            completion(.success(userResults))
        }
    }
}

//enum NetworkingError: Error {
//    case badUrl, invalidData
//}
