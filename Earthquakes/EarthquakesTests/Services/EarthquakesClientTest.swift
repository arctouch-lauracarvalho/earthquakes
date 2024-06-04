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
    
    func testGivenClientCreated_ThenHostAndNetworkSessionIsSet() {
        let host = URL(string: "https://example.com/v1")!
        let networkSession = URLSession.shared
        
        sut = EarthquakesClient(host: host, networkSession: networkSession)
        XCTAssertEqual(sut.host, host)
        XCTAssertEqual(sut.networkSession, networkSession)
    }
}
