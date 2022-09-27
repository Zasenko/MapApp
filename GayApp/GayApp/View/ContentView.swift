//
//  ContentView.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 22.09.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var placeModel: PlaceViewModel = PlaceViewModel()
    @State private var isPlaceViewOpen = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(PlaceType.allCases, id: \.self) { type in
                        Button {
                            withAnimation {
                                placeModel.selectedCategory = type
                            }
                        } label: {
                            Text(type.rawValue)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.secondary)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding()
            }
            List(placeModel.filteredPlaces) { place in
                
                VStack{
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: place.mainPhoto)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.red
                        }
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .shadow(radius: 5, x: 0, y: 3)
                        .shadow(radius: 10)
                        VStack{
                            Text(place.name)
                                .bold()
                            
                            Text(place.address)
                        }
                        .padding()
                    }
                    .padding()
                    .fullScreenCover(isPresented: $isPlaceViewOpen) {
                        PlaceView(isPlaceViewOpen: $isPlaceViewOpen, place: place)
                    }
                }
                .onTapGesture {
                    isPlaceViewOpen.toggle()
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
