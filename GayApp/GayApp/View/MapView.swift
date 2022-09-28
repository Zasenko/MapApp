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



struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
    @ObservedObject var placeViewModel: PlaceViewModel
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: placeViewModel.filteredPlaces2) { place in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)) {
                PlaceAnnotationView()
            }
        }
        .onChange(of: placeViewModel.filteredPlaces2) { _ in
            if !placeViewModel.filteredPlaces2.isEmpty {
                withAnimation {
                    self.region = regionThatFitsTo(coordinates: placeViewModel.filteredPlaces2.map({ place in
                        return CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    }))
                }
            }
            //                (coordinates: searchResults.map { $0.coordinate })
        }
    }
    
    func regionThatFitsTo(coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion {
        var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
        var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)
        for coordinate in coordinates {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, coordinate.latitude)
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, coordinate.latitude)
        }

        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.4
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.4
        return region
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(placeViewModel: PlaceViewModel())
//    }
//}

struct PlaceAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
    }
}
