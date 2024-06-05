//
//  MockSeismicAPIClient.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation
@testable import Earthquakes

final class MockSeismicAPIClient: SeismicAPIClient {
    let host: URL
    let networkSession: NetworkSession
    
    var mockResponse: [Earthquake]?
    var shouldThrowError: Bool = false
    
    init(host: URL = URL(string: "https://example.com")!,
         networkSession: NetworkSession = MockNetworkSession(mockData: "{}".data(using: .utf8)!, mockResponse: nil, errorToThrow: nil)) {
        self.host = host
        self.networkSession = networkSession
    }
    
    func fetchEarthquakesData() async throws -> [Earthquakes.Earthquake] {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        if shouldThrowError {
            throw URLError(.unknown)
        }
        
        if let mock = mockResponse {
            return mock
        } else {
            return []
        }
    }
}
