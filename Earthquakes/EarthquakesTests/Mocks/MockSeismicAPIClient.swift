//
//  MockSeismicAPIClient.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation
@testable import Earthquakes

final class MockSeismicAPIClient: SeismicAPIClient {
    var host: URL
    var networkSession: NetworkSession
    
    init(host: URL = URL(string: "https://example.com")!,
         networkSession: NetworkSession = MockNetworkSession(mockData: "{}".data(using: .utf8)!, mockResponse: nil, errorToThrow: nil)) {
        self.host = host
        self.networkSession = networkSession
    }
    
    func fetchEarthquakesData() async throws -> [Earthquakes.Earthquake] {
        return []
    }
}
