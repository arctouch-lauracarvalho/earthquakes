//
//  MockNetworkSession.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation
@testable import Earthquakes

final class MockNetworkSession: NetworkSession {
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        let mockData = "{}".data(using: .utf8)!
        let mockResonse = URLResponse()
        return (mockData, mockResonse)
    }
}
