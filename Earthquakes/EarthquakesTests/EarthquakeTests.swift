//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 03/06/24.
//

import XCTest
@testable import Earthquakes

final class EarthquakeTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
    
    func testEarthquakeInit() {
        let sut = Earthquake()
        XCTAssertNotNil(sut)
    }
}
