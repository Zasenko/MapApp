//
//  ContentView.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 22.09.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    var body: some View {
        switch locationDataManager.locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            PlacesView()
        case .restricted, .denied:
            Text("Current location data was restricted or denied.")
        case .notDetermined:
            VStack {
                Text("Finding your location...")
                ProgressView()
            }
        default:
            ProgressView()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
