//
//  PlaceViewModel.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 25.09.22.
//

import Foundation
import Combine
//import Contacts
//import CoreLocation

class PlaceViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var category: [PlaceType] = []
    @Published var selectedCategory: PlaceType = .all
    @Published var filteredPlaces: [Place] = []
    private var netv = PlaceNetworkManager()
    
}
extension PlaceViewModel {
    var filteredPlaces2: [Place] {
        switch selectedCategory {
        case .all:
            return places
        case .club:
            return places.filter({$0.type == .club})
        case .cafe:
            return places.filter({$0.type == .cafe})
        case .bar:
            return places.filter({$0.type == .bar})
        case .restaurant:
            return places.filter({$0.type == .restaurant})
        case .sauna:
            return places.filter({$0.type == .sauna})
        case .cruise:
            return places.filter({$0.type == .cruise})
        }
    }
    
    @MainActor
    func getPlaces() async throws {
        do {
            places = try await netv.getPlaces(user_latitude: userLocation.latitude, user_longitude: userLocation.longitude, radius: 20)
        } catch {
            print("Error:---", error)
        }
    }
//    func filterPlaces() {
//        switch selectedCategory {
//        case .all:
//            filteredPlaces = places
//        case .club:
//            filteredPlaces = places.filter({$0.type == .club})
//        case .cafe:
//            filteredPlaces = places.filter({$0.type == .cafe})
//        case .bar:
//            filteredPlaces = places.filter({$0.type == .bar})
//        case .restaurant:
//            filteredPlaces = places.filter({$0.type == .restaurant})
//        case .sauna:
//            filteredPlaces = places.filter({$0.type == .sauna})
//        case .cruise:
//            filteredPlaces = places.filter({$0.type == .cruise})
//        }
//    }
}
var userLocation: Location = Location(latitude: 48.21512, longitude: 16.37837)

//    func getAddressFromLocatoin(locatoin: CLLocation) -> String {
//        let ceo: CLGeocoder = CLGeocoder()
//        var addressString: String = ""
//        ceo.reverseGeocodeLocation(locatoin) { placemarks, error in
//            guard let place = placemarks?.first else {
//                print("No placemark from Apple: \(String(describing: error))")
//                return
//            }
//            let postalAddressFormatter = CNPostalAddressFormatter()
//            postalAddressFormatter.style = .mailingAddress
//            if let postalAddress = place.postalAddress {
//                addressString = postalAddressFormatter.string(from: postalAddress)
//            }
//        }
//        return addressString
//    }
