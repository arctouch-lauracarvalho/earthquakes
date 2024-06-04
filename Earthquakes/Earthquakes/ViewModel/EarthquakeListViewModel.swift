//
//  EarthquakeListViewModel.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

final class EarthquakeListViewModel: ObservableObject {
    private let earthquakeClient: SeismicAPIClient
    
    @MainActor @Published private(set) var isFetchingData: Bool = false
    @MainActor @Published private(set) var earthquakes: [Earthquake] = []
    
    init(earthquakeClient: SeismicAPIClient) {
        self.earthquakeClient = earthquakeClient
    }
    
    func fetchData() async {
        await MainActor.run {
            isFetchingData = true
        }
        
        do {
            let result = try await earthquakeClient.fetchEarthquakesData()
            
            await MainActor.run {
                self.isFetchingData = false
                self.earthquakes = result
            }
        } catch {
            
        }
    }
}
