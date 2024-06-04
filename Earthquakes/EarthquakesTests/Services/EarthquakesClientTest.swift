//
//  EarthquakesClientTests.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import XCTest
@testable import Earthquakes

final class EarthquakesClientTests: XCTestCase {
    private var sut: EarthquakesClient!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Instantiation Tests
    func testGivenClientCreated_ThenHostAndNetworkSessionIsSet() {
        let host = URL(string: "https://example.com/v1")!
        let networkSession: NetworkSession = URLSession.shared
        
        sut = setupClient(hostValue: "https://example.com/v1", networkSession: networkSession)
        XCTAssertEqual(sut.host, host)
        XCTAssertTrue(sut.networkSession === networkSession)
    }
    
    func testGivenEarthquakesClient_ThenItConformsToSeismicAPIClient() {
        sut = setupClient(networkSession: URLSession.shared)
        XCTAssertTrue((sut as AnyObject) is SeismicAPIClient)
    }

    // MARK: - Error Tests
    func testGivenEarthquakesClient_WhenFetchingEarthquakesDataAndThereIsNoInternetConnection_ThenThrowNoInternetError() async {
        var expectedError: SeismicAPIClientError = .invalidJSON
        let networkSession = setupNetworkSession(error: URLError(.notConnectedToInternet))
        
        sut = setupClient(networkSession: networkSession)
        
        do {
            _ = try await sut.fetchEarthquakesData()
        } catch {
            expectedError = error as! SeismicAPIClientError
        }
        
        XCTAssertEqual(expectedError, SeismicAPIClientError.noInternet)
    }
    
    func testGivenEarthquakesClient_WhenFetchingEarthquakesDataAndAnyErrorOccur_ThenThrowServerError() async {
        var expectedError: SeismicAPIClientError = .invalidJSON
        let networkSession = setupNetworkSession(error: URLError(.badURL))
        
        sut = setupClient(networkSession: networkSession)
        
        do {
            _ = try await sut.fetchEarthquakesData()
        } catch {
            expectedError = error as! SeismicAPIClientError
        }
        
        XCTAssertEqual(expectedError, SeismicAPIClientError.server)
    }
    
    func testGivenEarthquakesClient_WhenFetchingEarthquakesDataAndResponseCodeIsOtherThan200_ThenThrowServerError() async {
        var expectedError: SeismicAPIClientError = .invalidJSON
        let mockResponse = responseFor(url: "https://example.com/v1", statusCode: 500)
        let networkSession = setupNetworkSession(response: mockResponse)
        
        sut = setupClient(networkSession: networkSession)
        
        do {
            _ = try await sut.fetchEarthquakesData()
        } catch {
            expectedError = error as! SeismicAPIClientError
        }
        
        XCTAssertEqual(expectedError, SeismicAPIClientError.server)
    }
    
    func testGivenEarthquakesClient_WhenFetchingEarthquakesDataAndJSONIsInvalid_ThenThrowInvalidJSONError() async {
        var expectedError: SeismicAPIClientError = .noInternet
        let mockData = try! Data.fromJSON(fileName: "InvalidEarthquakeData")
        let mockResponse = responseFor(url: "https://example.com/v1", statusCode: 200)
        let networkSession = setupNetworkSession(using: mockData, response: mockResponse)
        
        sut = setupClient(networkSession: networkSession)
        
        do {
            _ = try await sut.fetchEarthquakesData()
        } catch {
            expectedError = error as! SeismicAPIClientError
        }
        
        XCTAssertEqual(expectedError, SeismicAPIClientError.invalidJSON)
    }
}

// MARK: - Helper Methods
private extension EarthquakesClientTests {
    func setupClient(hostValue: String = "https://example.com/v1",
                     networkSession: NetworkSession) -> EarthquakesClient {
        let host = URL(string: hostValue)!
        return EarthquakesClient(host: host, networkSession: networkSession)
    }
    
    func setupNetworkSession(using data: Data = "{}".data(using: .utf8)!,
                             response: URLResponse? = nil,
                             error: Error? = nil) -> MockNetworkSession {
        return MockNetworkSession(mockData: data, mockResponse: response, errorToThrow: error)
    }
    
    func responseFor(url: String, statusCode: Int = 200) -> HTTPURLResponse? {
        let finalURL = URL(string: url)!
        return HTTPURLResponse(url: finalURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}
