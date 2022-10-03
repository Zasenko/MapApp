//
//  MapView.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 27.09.22.
//

import SwiftUI
import MapKit

struct MyAnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

enum MapDetails {
    static let startingDefaultLocation = CLLocationCoordinate2D(latitude: 37.334900,
                                                                longitude: -122.009020)
    static let startingDefaultLatitudinalMeters: Double = 1000
    static let startingDefaultLongitudinalMeters: Double = 1000
}

struct MapView: View {
    
    @ObservedObject var locationDataManager: LocationDataManager
    @ObservedObject var placeViewModel: PlaceViewModel
    var body: some View {
        
        Map(coordinateRegion: $locationDataManager.region, interactionModes: .all, showsUserLocation: true, annotationItems: placeViewModel.filteredPlaces2) { place in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)) {
                PlaceAnnotationView(pin: placeViewModel.getPinColor(place: place.type))
            }
        }
        .accentColor(.red) ///user location Circle's color on map
        .onAppear {
            locationDataManager.checkIfLocationServicesIsEnabled()
            Task {
                do {
                    try await placeViewModel.getPlaces()
                } catch {
                    print("Error", error) // TODO!!!!
                }
            }
        }
        .onChange(of: placeViewModel.filteredPlaces2) { newLocations in
            print("new locations------------------ \(newLocations)")
            var locations: [CLLocationCoordinate2D] = []
            for location in newLocations {
                let a = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                locations.append(a)
            }
            guard let userLocation = locationDataManager.locationManager.location else { return }
            locations.append(userLocation.coordinate)
            withAnimation(.spring()){
                self.locationDataManager.region = locationDataManager.regionThatFitsTo(coordinates: locations)
            }
        }
    }
}

struct PlaceAnnotationView: View {
    
    let pin: (Color, String)
    
    var body: some View {
        VStack(spacing: 0) {
            Text(pin.1)
                .padding()
                .background {
                    pin.0
                }
                .clipShape(Circle())
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(pin.0)
                .offset(x: 0, y: -5)
        }
    }
}
struct PlaceAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceAnnotationView(pin: (.blue, "🪩"))
    }
}
