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

//var placesArray: [Place] = [Place(id: 1, name: "Cafe Savoy", types: .cafe, descriptions: nil, city: "Vienna", country: "Austria", address: "", location: Location(latitude: 48.19760, longitude: 16.36011), mainPhoto: "https://www.coffeelifestyler.com/wp-content/uploads/2021/06/Cafe-Savoy.jpg", photos: nil, wwwLink: "https://www.cafe-savoy.at")]

class PlaceViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var selectedCategory: PlaceType = .cafe
    private var cancellable: AnyCancellable?
    
    private let userModel = UserViewModel()
    
    var filteredPlaces: [Place] {
        switch selectedCategory {
        case .club:
            return places.filter({$0.type == .club})
        case .cafe:
            return places.filter({$0.type == .cafe})
        case .bars:
            return places.filter({$0.type == .bars})
        case .restaurants:
            return places.filter({$0.type == .restaurants})
        case .saunas:
            return places.filter({$0.type == .saunas})
        }
    }
    
    func getPlaces() {
        cancellable = PlaceNetworkManager.shared.getUsers(user_latitude: userModel.userLocation.latitude , user_longitude: userModel.userLocation.longitude , radius: 20)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
//                    // 4
//                    self.isRequestFailed = true
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { users in
                self.places.append(contentsOf: users)
              //  self.currentLastId = users.last?.id
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
