//
//  Network.swift
//  Pokedex
//
//  Created by Luis Pineda on 19/08/21.
//

import Foundation

import Combine

protocol NetworkProtocol: AnyObject {
    func get<T>(type: T.Type,
                urlRequest: URLRequest) -> AnyPublisher<T, Error> where T: Decodable
}

class Network: NetworkProtocol {
    func get<T>(type: T.Type, urlRequest: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
