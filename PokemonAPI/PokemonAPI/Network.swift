//
//  Network.swift
//  PokemonAPI
//
//  Created by Carlos Wilson on 14/10/21.
//

import Foundation
import Alamofire

enum FailureType: String {
    case badResponse
}

enum NetworkError: Error {
    case badResponse
    case noData
}

enum Endpoint: String {
    case pokemonAPI = "https://private-d1eba-pokemon33.apiary-mock.com/pokemonList"
}

struct Network {
    static func pokemnoURL(endpoint: Endpoint) -> String {
        return endpoint.rawValue
    }


func completion(result: Result<[Pokemon], NetworkError>) {
    print(result)
}


static func getFromServer(completion: @escaping (Result<[Pokemon], NetworkError>) -> Void) {
    let endpoint = Endpoint.pokemonAPI.rawValue
    
    AF.request(endpoint).responseJSON { response in
        guard let itemsData = response.data else {
            completion(.failure(.badResponse))
            return
        }
        do {
            let decoder = JSONDecoder()
            let items = try decoder.decode([Pokemon].self, from: itemsData)
            completion(.success(items))
            
        } catch {
            completion(.failure(.noData))
        }
    }
}
}



