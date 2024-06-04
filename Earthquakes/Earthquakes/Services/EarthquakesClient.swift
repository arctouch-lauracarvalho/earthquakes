//
//  EarthquakesClient.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

final class EarthquakesClient: SeismicAPIClient {
    let host: URL
    let networkSession: NetworkSession
    
    init(host: URL, networkSession: NetworkSession) {
        self.host = host
        self.networkSession = networkSession
    }
    
    func fetchEarthquakesData() async throws -> [Earthquake] {
        return []
    }
}
