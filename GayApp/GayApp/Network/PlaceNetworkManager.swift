//
//  PlaceNetworkManager.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 27.09.22.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
}

class PlaceNetworkManager {
    static let shared = PlaceNetworkManager()
    
    private let scheme = "https"
    private let host = "zasik.000webhostapp.com"

    func getUsers(user_latitude: Double, user_longitude: Double, radius: Int) -> AnyPublisher<[Place], Error> {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "/get_places_by_location.php"
            components.queryItems = [URLQueryItem(name: "user_latitude", value: String(user_latitude)),
                                     URLQueryItem(name: "user_longitude", value: String(user_longitude)),
                                     URLQueryItem(name: "radius", value: String(radius))]
            return components
        }
        let url = urlComponents.url!// else { throw NetworkError.badUrl }
        print(url)
        let request = URLRequest(url: url, timeoutInterval: 10)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Place].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
