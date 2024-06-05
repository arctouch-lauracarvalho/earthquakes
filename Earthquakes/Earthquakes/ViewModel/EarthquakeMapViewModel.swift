//
//  EarthquakeMapViewModel.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation
import MapKit

final class EarthquakeMapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published private(set) var annotations: [Pin] = []
    
    private let centerCoordinates: CLLocationCoordinate2D
    
    init(coordinates: Coordinates) {
        self.centerCoordinates = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    func setUpData() async {
        await MainActor.run {
            region = MKCoordinateRegion(
                center: centerCoordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            
            annotations = [
                Pin(coordinate: centerCoordinates)
            ]
        }
    }
}

struct Pin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
