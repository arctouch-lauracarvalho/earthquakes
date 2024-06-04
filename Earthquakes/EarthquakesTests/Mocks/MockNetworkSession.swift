//
//  MockNetworkSession.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation
@testable import Earthquakes

final class MockNetworkSession: NetworkSession {
    private let jsonDataAsString: String
    private let mockResponse: URLResponse?
    private let errorToThrow: Error?
    
    init(mockDataString: String, mockResponse: URLResponse?, errorToThrow: Error?) {
        jsonDataAsString = mockDataString
        self.mockResponse = mockResponse
        self.errorToThrow = errorToThrow
    }
    
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        if let error = errorToThrow {
            throw error
        }
        
        let mockData = jsonDataAsString.data(using: .utf8)!
        
        var response: URLResponse
        if let responseToMock = mockResponse {
            response = responseToMock
        } else {
            response = URLResponse()
        }
        
        return (mockData, response)
    }
}
