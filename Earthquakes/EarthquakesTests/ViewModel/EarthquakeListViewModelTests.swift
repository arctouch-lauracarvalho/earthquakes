//
//  EarthquakeListViewModelTests.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import XCTest
@testable import Earthquakes

final class EarthquakeListViewModelTests: XCTestCase {
    private var sut: EarthquakeListViewModel!
    private var mockAPIClient: SeismicAPIClient!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockSeismicAPIClient()
        sut = EarthquakeListViewModel(earthquakeClient: mockAPIClient)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIClient = nil
        super.tearDown()
    }
    
    func testWhenInstantiateViewModel_ThenisFetchingDataIsFalseAndEarthquakeDataIsEmpty() {
        XCTAssertFalse(sut.isFetchingData)
        XCTAssertTrue(sut.earthquakes.isEmpty)
    }
    
    func testGivenViewModel_WhenCallingFetchData_ThenIsFechingDataIsTrue() {
        sut.fetchData()
        XCTAssertTrue(sut.isFetchingData)
    }
}
