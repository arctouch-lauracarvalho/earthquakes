//
//  EarthquakeCellViewModelTests.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import XCTest
@testable import Earthquakes

final class EarthquakeCellViewModelTests: XCTestCase {
    private var sut: EarthquakeCellViewModel!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGivenEarthquake_WhenInstantiateViewModel_ThenTitleIsEarthquakeTitle() {
        let expectedEarthquake = mockEarthquakeData()
        
        sut = EarthquakeCellViewModel(earthquake: expectedEarthquake)
        XCTAssertEqual(sut.title, expectedEarthquake.title)
    }
    
    func testGivenEarthquake_WhenInstantiateViewModel_ThenDateIsFormated() {
        let expectedEarthquake = mockEarthquakeData()
        
        sut = EarthquakeCellViewModel(earthquake: expectedEarthquake)
        XCTAssertEqual(sut.formatedDate, "Dec 7, 2023 at 9:56 AM")
    }
    
    func testGivenEarthquake_WhenInstantiateViewModel_ThenDepthIsFormated() {
        let expectedEarthquake = mockEarthquakeData()
        
        sut = EarthquakeCellViewModel(earthquake: expectedEarthquake)
        XCTAssertEqual(sut.depth, "48.0 Km depth")
    }
    
    func testGivenEarthquake_WhenInstantiateViewModel_ThenMagniguteIsFormated() {
        let expectedEarthquake = mockEarthquakeData()
        
        sut = EarthquakeCellViewModel(earthquake: expectedEarthquake)
        XCTAssertEqual(sut.magnitude, "1.0")
    }
    
    func testGivenEarthquakeWithMagnitude7_4_WhenInstantiateViewModel_ThenShouldBeDistinguishIsFalse() {
        let expectedEarthquake = mockEarthquakeData(withMagnitute: 7.4)
        
        sut = EarthquakeCellViewModel(earthquake: expectedEarthquake)
        XCTAssertFalse(sut.shouldBeDistinguish)
    }
    
    func testGivenEarthquakeWithMagnitude7_5_WhenInstantiateViewModel_ThenShouldBeDistinguishIsTrue() {
        let expectedEarthquake = mockEarthquakeData(withMagnitute: 7.5)
        
        sut = EarthquakeCellViewModel(earthquake: expectedEarthquake)
        XCTAssertFalse(sut.shouldBeDistinguish)
    }
    
    func testGivenEarthquakeWithMagnitude7_6_WhenInstantiateViewModel_ThenShouldBeDistinguishIsTrue() {
        let expectedEarthquake = mockEarthquakeData(withMagnitute: 7.6)
        
        sut = EarthquakeCellViewModel(earthquake: expectedEarthquake)
        XCTAssertFalse(sut.shouldBeDistinguish)
    }
}

// MARK: - Helper Methods
private extension EarthquakeCellViewModelTests {
    func mockEarthquakeData(withMagnitute magnitude: Double = 1.0) -> Earthquake {
        let jsonData = """
            {
                "properties": {
                    "title": "Big Earthquake",
                    "mag": \(magnitude),
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
            
            let decoder = JSONDecoder()
            return try! decoder.decode(Earthquake.self, from: jsonData)
    }
}
