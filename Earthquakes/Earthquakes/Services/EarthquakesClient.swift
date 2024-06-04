//
//  EarthquakesClient.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

final class EarthquakesClient {
    let host: URL
    let networkSession: URLSession
    
    init(host: URL, networkSession: URLSession) {
        self.host = host
        self.networkSession = networkSession
    }
}
