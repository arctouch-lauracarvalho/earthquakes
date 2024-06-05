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
    @MainActor @Published var shouldDisplayAlert: Bool = false
    
    private(set) var apiError: SeismicAPIClientError?
    
    private static var host: URL {
        guard let url = URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-01-01&endtime=2024-01-01&minmagnitude=7") else {
            fatalError("Invalid host URL")
        }
        return url
    }
    
    convenience init() {
        let client = EarthquakesClient(host: Self.host, networkSession: URLSession.shared)
        self.init(earthquakeClient: client)
    }
    
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
            apiError = error as? SeismicAPIClientError
            
            await MainActor.run {
                self.isFetchingData = false
                self.shouldDisplayAlert = true
            }
        }
    }
}
