//
//  EarthquakeListViewModelTests.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import XCTest
import Combine
@testable import Earthquakes

final class EarthquakeListViewModelTests: XCTestCase {
    private var sut: EarthquakeListViewModel!
    private var mockAPIClient: MockSeismicAPIClient!
    private var cancellables = Set<AnyCancellable>()

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
    
    func testWhenInstantiateViewModel_ThenisFetchingDataIsFalseAndEarthquakeDataIsEmpty() async {
        await MainActor.run {
            XCTAssertFalse(sut.isFetchingData)
            XCTAssertTrue(sut.earthquakes.isEmpty)
        }
    }
    
    func testGivenViewModel_WhenFetchingDataAndItIsSuccessuful_ThenIsFechingDataIsFalse() async {
        var receivedValue = true
        
        sut.$isFetchingData
            .dropFirst()
            .sink { result in
                receivedValue = result
            }
            .store(in: &cancellables)
        
        await sut.fetchData()
        
        XCTAssertFalse(receivedValue)
    }
    
    func testGivenViewModel_WhenFetchingDataAndItIsSuccessuful_ThenSetsEarthquakeList() async {
        let mockEarthquakeList = setupEarthquakeMockData()
        mockAPIClient.mockResponse = mockEarthquakeList
        
        var receivedResult = [Earthquake]()
        
        sut.$earthquakes
            .dropFirst()
            .sink { result in
                receivedResult = result
            }
            .store(in: &cancellables)
        
        await sut.fetchData()
        
        XCTAssertEqual(receivedResult, mockEarthquakeList)
    }
    
    func testGivenViewModel_WhenFetchingDataAndItFails_ThenSetsShouldShowAlertToTrue() async {
        await MainActor.run {
            XCTAssertFalse(sut.shouldDisplayAlert)
        }
        
        mockAPIClient.shouldThrowError = true
        
        sut.$shouldDisplayAlert
            .dropFirst()
            .sink { result in
                _ = result
            }
            .store(in: &cancellables)
        
        await sut.fetchData()
        
        await MainActor.run {
            XCTAssertTrue(sut.shouldDisplayAlert)
        }
    }
}

private extension EarthquakeListViewModelTests {
    func setupEarthquakeMockData() -> [Earthquake] {
        let mockData = try! Data.fromJSON(fileName: "EarthquakeListData")
        
        let decoder = JSONDecoder()
        let decodedResult = try! decoder.decode(EarthquakeResponse.self, from: mockData)
        let earthquakesList = decodedResult.features
        return earthquakesList
    }
}
