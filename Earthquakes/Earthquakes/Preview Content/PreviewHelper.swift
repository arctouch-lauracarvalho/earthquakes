//
//  PreviewHelper.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

struct PreviewHelper {
    static var smallEarthquake: Earthquake {
        let jsonData = """
            {
                "properties": {
                    "title": "Small Earthquake",
                    "mag": 3.0,
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
    
    static var bigEarthquake: Earthquake {
        let jsonData = """
            {
                "properties": {
                    "title": "Big Earthquake",
                    "mag": 7.6,
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
