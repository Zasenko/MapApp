//
//  UserViewModel.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 27.09.22.
//

import Foundation
import CoreLocation

class User {
    static let shared = User()
    private init () {}
    var userLocation: CLLocationCoordinate2D =  CLLocationCoordinate2D(latitude: 42.21512, longitude: 16.37237)
}

