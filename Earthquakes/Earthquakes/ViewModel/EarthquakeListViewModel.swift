//
//  EarthquakeListViewModel.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

final class EarthquakeListViewModel: ObservableObject {
    private let earthquakeClient: SeismicAPIClient
    
    @Published private(set) var isFetchingData: Bool
    @Published private(set) var earthquakes: [Earthquake]
    
    init(earthquakeClient: SeismicAPIClient) {
        self.earthquakeClient = earthquakeClient
        
        isFetchingData = false
        earthquakes = []
    }
    
    func fetchData() {
        isFetchingData = true
    }
}
