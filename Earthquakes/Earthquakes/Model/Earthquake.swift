//
//  Earthquake.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 03/06/24.
//

import Foundation

struct EarthquakeResponse: Decodable {
    let features: [Earthquake]
}

struct Earthquake: Decodable {
    let title: String
    let magnitude: Double
    let time: Int64
    let coordinates: Coordinates
    
    private let geometryExpectedAmountOfData = 3
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let propertiesContainer = try container.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
        self.title = try propertiesContainer.decode(String.self, forKey: .title)
        self.magnitude = try propertiesContainer.decode(Double.self, forKey: .magnitude)
        self.time = try propertiesContainer.decode(Int64.self, forKey: .time)
        
        let geometryContainer = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
        let geometryData = try geometryContainer.decode([Double].self, forKey: .coordinates)
        
        let geometryHasExpectedAmountOfData = geometryData.count == 3
        
        if geometryHasExpectedAmountOfData {
            self.coordinates = Coordinates(latitude: geometryData[1], longitude: geometryData[0], depth: geometryData[2])
        } else {
            self.coordinates = Coordinates.empty()
        }
    }
}

extension Earthquake: Equatable {}

extension Earthquake: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
}

extension Earthquake {
    private init() {
        title = ""
        magnitude = 0.0
        time = 0
        coordinates = Coordinates.empty()
    }
    
    private enum CodingKeys: String, CodingKey {
        case properties
        case geometry
    }
    
    private enum PropertiesKeys: String, CodingKey {
        case title
        case magnitude = "mag"
        case time
    }
    
    private enum GeometryKeys: String, CodingKey {
        case coordinates
    }
}
