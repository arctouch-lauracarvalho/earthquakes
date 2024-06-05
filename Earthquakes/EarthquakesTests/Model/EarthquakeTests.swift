//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 03/06/24.
//

import XCTest
@testable import Earthquakes

final class EarthquakeTests: XCTestCase {
    private var sut: Earthquake!

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testEarthquakeInitFromValidJSON() {
        let decoder = JSONDecoder()
        let data = try! Data.fromJSON(fileName: "EarthquakeValidData")
        sut = try! decoder.decode(Earthquake.self, from: data)
        
        XCTAssertEqual(sut.title, "Some title")
        XCTAssertEqual(sut.magnitude, 1.0)
        XCTAssertEqual(sut.time, 1701953790184)
        XCTAssertEqual(sut.coordinates, Coordinates(latitude: -20.6152, longitude: 169.3089, depth: 48))
    }
    
    func testEartquakeInitFromInvalidJSON() {
        let decoder = JSONDecoder()
        let data = try! Data.fromJSON(fileName: "InvalidEarthquakeData")
        XCTAssertThrowsError(try decoder.decode(Earthquake.self, from: data))
    }
}
