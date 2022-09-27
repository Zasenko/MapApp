//
//  PlaceViewModel.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 25.09.22.
//

import Foundation
//import Contacts
//import CoreLocation

var placesArray: [Place] = [Place(id: 1, name: "Cafe Savoy", types: .cafe, descriptions: nil, city: "Vienna", country: "Austria", address: "", location: Location(latitude: 48.19760, longitude: 16.36011), mainPhoto: "https://www.coffeelifestyler.com/wp-content/uploads/2021/06/Cafe-Savoy.jpg", photos: nil, wwwLink: "https://www.cafe-savoy.at")]

class PlaceViewModel: ObservableObject {
    @Published var places: [Place] = placesArray
    @Published var selectedCategory: PlaceType = .cafe
    
    var filteredPlaces: [Place] {
        switch selectedCategory {
        case .club:
            return places.filter({$0.types == .club})
        case .cafe:
            return places.filter({$0.types == .cafe})
        case .bars:
            return places.filter({$0.types == .bars})
        case .restaurants:
            return places.filter({$0.types == .restaurants})
        case .saunas:
            return places.filter({$0.types == .saunas})
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
}
