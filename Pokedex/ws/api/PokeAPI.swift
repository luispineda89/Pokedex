//
//  PokeAPI.swift
//  Pokedex
//
//  Created by Luis Pineda on 6/07/21.
//

import Foundation
import ComposableArchitecture
import Combine

struct ErrorMessage: Swift.Error, Equatable {
    let code: Int
    let message: String
    
    init(_ code: Int,
         _ message: String) {
        self.code = code
        self.message = message
    }
}

struct PokeAPI {
    
    static let jsonDecoder: JSONDecoder = {
        let d = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        d.dateDecodingStrategy = .formatted(formatter)
        return d
    }()
    
    static func send<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> Effect<T, ErrorMessage> {
        
        //TODO: Quitar el print al finalizar el desarrollo
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .mapError{
                ErrorMessage($0.errorCode, $0.localizedDescription)
            }
            .map { $0.data }
            .decode(type: T.self, decoder: jsonDecoder)
            .print()
            .mapError { _ in
                ErrorMessage(200, "Error Decode")
            }
            .eraseToEffect()
    }
    
}
