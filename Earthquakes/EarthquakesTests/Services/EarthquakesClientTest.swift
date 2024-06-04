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
        let networkSession = URLSession.shared
        
        sut = setupClient(hostValue: "https://example.com/v1")
        XCTAssertEqual(sut.host, host)
        XCTAssertEqual(sut.networkSession, networkSession)
    }
    
    func testGivenEarthquakesClient_ThenItConformsToSeismicAPIClient() {
        sut = setupClient()
        XCTAssertTrue((sut as AnyObject) is SeismicAPIClient)
    }
}

private extension EarthquakesClientTests {
    func setupClient(hostValue: String = "https://example.com/v1",
                     networkSession: URLSession = URLSession.shared) -> EarthquakesClient {
        let host = URL(string: hostValue)!
        return EarthquakesClient(host: host, networkSession: networkSession)
    }
}
