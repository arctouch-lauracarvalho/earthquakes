//
//  Coordinates.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 03/06/24.
//

import Foundation

struct Coordinates: Equatable {
    let latitude: Double
    let longitude: Double
    let depth: Double
    
    static func empty() -> Coordinates {
        .init(latitude: 0, longitude: 0, depth: 0)
    }
}
