//
//  File.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 22.09.22.
//
import Foundation
//protocol PlaceProtocol: Identifiable {
//    var id: Int { get }
//    var name: String { get }
//    var type: PlaceType { get }
//}

enum PlaceType: String, Codable, CaseIterable {
    case club, cafe, bars, restaurants, saunas
}

struct Place: Codable, Identifiable {
    let id: Int
    let name: String
    let type: PlaceType
    let description: String?
//    let city: String
//    let country: String
   // var address: String
    
    let latitude: Double
    let longitude: Double
    
   // let location: Location
  //  let mainPhoto: String
  //  let photos: [String]?
   /// let wwwLink: String?
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}
