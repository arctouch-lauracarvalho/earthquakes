//
//  EarthquakeMapDetail.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import SwiftUI
import MapKit

struct EarthquakeMapDetail: View {
    @ObservedObject var viewModel: EarthquakeMapViewModel
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.annotations) {
            MapMarker(coordinate: $0.coordinate)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Map Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.setUpData()
            }
        }
    }
}

#Preview {
    let coordinates = Coordinates(latitude: 48.8567, longitude: 2.3508, depth: 0.0)
    return EarthquakeMapDetail(viewModel: EarthquakeMapViewModel(coordinates: coordinates))
}
