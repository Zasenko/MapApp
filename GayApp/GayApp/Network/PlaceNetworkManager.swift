//
//  PlaceNetworkManager.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 27.09.22.
//

import Foundation
import Combine

enum FetchError: Error {
    case badUrl, statusNot200, decoderError
}

final class PlaceNetworkManager {
    static let shared = PlaceNetworkManager()
    
    private let scheme = "https"
    private let host = "zasik.000webhostapp.com"
    
    func getPlaces(latitude: Double, longitude: Double, radius: Int) async throws -> [Place] {
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = "/get_places_by_location.php"
            components.queryItems = [URLQueryItem(name: "user_latitude", value: String(latitude)),
                                     URLQueryItem(name: "user_longitude", value: String(longitude)),
                                     URLQueryItem(name: "radius", value: String(radius))]
            return components
        }
        guard let url = urlComponents.url else {
            throw FetchError.badUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.statusNot200
        }
        guard let decodedCoctails = try? JSONDecoder().decode([Place].self, from: data) else {
            throw FetchError.decoderError
        }
        print("decodedCoctails---------------------\(decodedCoctails)")
        return decodedCoctails
    }
    
    
}


