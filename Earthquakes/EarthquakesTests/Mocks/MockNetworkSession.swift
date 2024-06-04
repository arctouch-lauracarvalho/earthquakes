//
//  MockNetworkSession.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation
@testable import Earthquakes

final class MockNetworkSession: NetworkSession {
    private let jsonData: Data
    private let mockResponse: URLResponse?
    private let errorToThrow: Error?
    
    init(mockData: Data, mockResponse: URLResponse?, errorToThrow: Error?) {
        jsonData = mockData
        self.mockResponse = mockResponse
        self.errorToThrow = errorToThrow
    }
    
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        if let error = errorToThrow {
            throw error
        }
        
        var response: URLResponse
        if let responseToMock = mockResponse {
            response = responseToMock
        } else {
            response = URLResponse()
        }
        
        return (jsonData, response)
    }
}
