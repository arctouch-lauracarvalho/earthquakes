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
    
    func testGivenClientCreated_ThenHostAndNetworkSessionIsSet() {
        let host = URL(string: "https://example.com/v1")!
        let networkSession: NetworkSession = URLSession.shared
        
        sut = setupClient(hostValue: "https://example.com/v1", networkSession: networkSession)
        XCTAssertEqual(sut.host, host)
        XCTAssertTrue(sut.networkSession === networkSession)
    }
    
    func testGivenEarthquakesClient_ThenItConformsToSeismicAPIClient() {
        sut = setupClient()
        XCTAssertTrue((sut as AnyObject) is SeismicAPIClient)
    }
    
    func testGivenEarthquakesClient_WhenFetchingEarthquakesData_ThenResponseIsEmpty() async {
        sut = setupClient()
        do {
            let responseList = try await sut.fetchEarthquakesData()
            XCTAssertTrue(responseList.isEmpty)
        } catch {
            XCTFail("🚫 an error is thrown \(error)")
        }
    }
}

private extension EarthquakesClientTests {
    func setupClient(hostValue: String = "https://example.com/v1",
                     networkSession: NetworkSession = MockNetworkSession()) -> EarthquakesClient {
        let host = URL(string: hostValue)!
        return EarthquakesClient(host: host, networkSession: networkSession)
    }
}
