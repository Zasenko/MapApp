//
//  PlacesView.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 28.09.22.
//

import SwiftUI

struct PlacesView: View {
    @StateObject var placeViewModel = PlaceViewModel()
    @State private var changedToList = false
    
    var body: some View {
        ZStack {
                MapView(placeViewModel: placeViewModel)
                    .ignoresSafeArea()
                    .task {
                        do {
                            try await placeViewModel.getPlaces()
                        } catch {
                            print("Error", error) // TODO!!!!
                        }
                    }
            
            VStack {
                HStack {
                    Toggle("", isOn: $changedToList)
                }
                ForEach(PlaceType.allCases, id: \.self) { type in
                    Button {
                        placeViewModel.selectedCategory = type
                    } label: {
                        Text(type.rawValue)
                    }

                }
                Spacer()
            }
            .padding()
        }
        
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}
//
//struct PlacesListView: View {
//    
//    @ObservedObject var placeViewModel: PlaceViewModel
//
//    var body: some View {
//        List(placeViewModel.filteredPlaces) { place in
//            VStack{
//                HStack(alignment: .top) {
//                    AsyncImage(url: URL(string: place.photo)) { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        Color.red
//                    }
//                    .frame(width: 100, height: 100)
//                    .cornerRadius(10)
//                    .shadow(radius: 5, x: 0, y: 3)
//                    .shadow(radius: 10)
//                    VStack{
//                        Text(place.name)
//                            .bold()
//                    }
//                    .padding()
//                }
//                .padding()
//            }
//            .listRowSeparator(.hidden)
//        }
//        .listStyle(.plain)
//        .frame(height: 300)
//    }
//}
