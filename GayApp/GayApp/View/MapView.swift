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
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.19760, longitude: 16.36011), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    var annotationItems: [MyAnnotationItem] = [MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 48.19760, longitude: 16.36011))]
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, annotationItems: annotationItems) { item in
            MapAnnotation(coordinate: item.coordinate) {
                PlaceAnnotationView()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

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
