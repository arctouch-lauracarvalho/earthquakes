//
//  EarthquakeMapDetail.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import SwiftUI
import MapKit

struct EarthquakeMapDetail: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Map Detail")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EarthquakeMapDetail()
}
