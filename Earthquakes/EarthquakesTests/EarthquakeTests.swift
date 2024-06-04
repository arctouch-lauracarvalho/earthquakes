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
        
        sut = try! decoder.decode(Earthquake.self, from: validJSONData)
        
        XCTAssertEqual(sut.title, "Some title")
        XCTAssertEqual(sut.magnitude, 1.0)
        XCTAssertEqual(sut.time, 1701953790184)
        XCTAssertEqual(sut.coordinates, Coordinates(latitude: 169.3089, longitude: -20.6152, depth: 48))
    }
    
    func testEartquakeInitFromInvalidJSON() {
        let decoder = JSONDecoder()
        XCTAssertThrowsError(try decoder.decode(Earthquake.self, from: jsonDataMissingMagnitude))
    }
}

private extension EarthquakeTests {
    var validJSONData: Data {
        """
            {
                "properties": {
                    "title": "Some title",
                    "mag": 1.0,
                    "time": 1701953790184,
                },
                "geometry": {
                        "type": "Point",
                        "coordinates": [
                            169.3089,
                            -20.6152,
                            48
                        ]
                    }
            }
        """.data(using: .utf8)!
    }
    
    var jsonDataMissingMagnitude: Data {
        """
            {
                "properties": {
                    "title": "Some title",
                    "time": 1701953790184,
                },
                "geometry": {
                        "type": "Point",
                        "coordinates": [
                            169.3089,
                            -20.6152,
                            48
                        ]
                    }
            }
        """.data(using: .utf8)!
    }
}
