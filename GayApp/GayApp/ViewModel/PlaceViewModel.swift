//
//  PlaceViewModel.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 25.09.22.
//

import SwiftUI
//import Contacts

final class PlaceViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var category: [PlaceType] = []
    @Published var selectedCategory: PlaceType = .all
    private var placeNetworkManager = PlaceNetworkManager()
    
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
            places = try await placeNetworkManager.getPlaces(latitude: User.shared.userLocation.latitude, longitude: User.shared.userLocation.longitude, radius: 20)
            category = places.map({$0.type}).uniqued()
        } catch {
            print("Error:---", error)
        }
    }
    
    func getPinColor(place type: PlaceType) -> (Color, String) {
        switch type {
        case .all:
            return (.black, "")
        case .club:
            return (Color.blue, "🪩")
        case .cafe:
            return (Color.orange, "☕️")
        case .bar:
            return (Color.black, "🍾")
        case .restaurant:
            return (Color.yellow, "🍽")
        case .sauna:
            return (Color.blue, "🧖")
        case .cruise:
            return (Color.black, "😈")
        }
    }
}
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
