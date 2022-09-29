//
//  LocationDataManager.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 28.09.22.
//

import Foundation
import MapKit

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {

  //  @Published var places = [Place]()
    @Published var region = MKCoordinateRegion(
        center: MapDetails.startingDefaultLocation,
        latitudinalMeters: MapDetails.startingDefaultLatitudinalMeters,
        longitudinalMeters: MapDetails.startingDefaultLongitudinalMeters
        )
    var locationManager = CLLocationManager()
    
    func checkIfLocationServicesIsEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    //    locationManager.startUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAutorization()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let center = locations.last?.coordinate else { return }
//        region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
//    }
    
    private func checkLocationAutorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this App location permission. Go into settings to change it. ")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let center = locationManager.location?.coordinate else { return }
            User.shared.userLocation = center
            region = MKCoordinateRegion(center: center, latitudinalMeters: MapDetails.startingDefaultLatitudinalMeters, longitudinalMeters: MapDetails.startingDefaultLongitudinalMeters)
        @unknown default:
            break
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
