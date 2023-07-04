//
//  NetworkServiceWithCompletions.swift
//  Networking
//
//  Created by Никитин Артем on 4.07.23.
//
// КЛАССАИЧЕСКИЙ СПОСОБ КОГДА ВСЮ АСИНХРОННОСТЬ И МНОГОПОТОЧНОСТЬ МЫ КОМПЕНСИРУЕМ КОМПЛИШЕНАМИ

import Foundation

class NetworkServiceWithCompletions {
    
    // 1. создали синглтон
    static let shared = NetworkServiceWithCompletions(); private init() { }
    
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
    
    // 3. После того как данные будут получены, будет выполнен комплишн блок!!!
    func fetchData(completion: @escaping (Result<UserResaults, Error>) -> ()) {
        
        // 1.Пробуем получить УРЛ
        guard let url = createURL() else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        // 2.Обращаемся к URLSession для работы с сетью
        // Комплишн будет исполнен только после получения данных!!!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            // Создали JSON Декодер и парсим данные 
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let usersData = try decoder.decode(UserResaults.self, from: data)
                completion(.success(usersData))
            } catch {
                completion(.failure(NetworkingError.invalidData))
            }
            
        }.resume()
    }
}

enum NetworkingError: Error {
    case badUrl, invalidData
}
