//
//  PlaceView.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 25.09.22.
//

import SwiftUI

struct PlaceView: View {
    
    @Binding var isPlaceViewOpen: Bool
    var place: Place
    
    @State var address: String = ""

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: place.mainPhoto)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.red
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            .cornerRadius(0)
            
            Text(place.name)
            
            if let description = place.descriptions {
                Text(description)
            }
            
            VStack {
                Text("Address:")
                    .bold()
                Text(address)
            }
            .frame(maxWidth: .infinity)
            .background {
                Color.gray.opacity(0.2)
            }
            Spacer()
            MapView()
                .frame(height: 100)
            
            if let wwwLink = place.wwwLink {
                Link("visit site", destination: URL(string: wwwLink)!) //TODO
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(20)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(isPlaceViewOpen: .constant(true), place: placesArray[0])
    }
}
