//
//  EarthquakeCellViewModel.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

struct EarthquakeCellViewModel {
    let earthquake: Earthquake
    
    var title: String {
        earthquake.title
    }
    
    var formatedDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(earthquake.time / 1000))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var depth: String {
        String(format: "%.1f Km depth", earthquake.coordinates.depth)
    }
    
    var magnitude: String {
        String(format: "%.1f", earthquake.magnitude)
    }
    
    var shouldBeDistinguish: Bool {
        earthquake.magnitude >= 7.5
    }
}
