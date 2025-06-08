//
//  NetworkManager.swift
//  TaskOne
//
//  Created by Sumanth Maddela on 08/06/25.
//

import Foundation

protocol NetworkManagerProtocol {
    func networkCall<T: Decodable>(request: URL?, completion: @escaping (Result<T,Error>) -> Void)
}

enum NetworkError : Error {
    case inValidUrl
    case someError(error: Error)
    case noData
    case parsingFailed
}

class NetworkManager:  NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func networkCall<T: Decodable>(request: URL?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = request else {
            completion(.failure(NetworkError.inValidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(NetworkError.someError(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.parsingFailed))
            }
        }.resume()
    }

}
