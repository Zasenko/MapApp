//
//  UserViewModel.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 27.09.22.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    @Published var userLocation: Location = Location(latitude: 48.21512, longitude: 16.37837)
        
}
