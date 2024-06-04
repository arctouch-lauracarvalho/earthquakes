//
//  SeismicAPIClient.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

protocol SeismicAPIClient: AnyObject {
    var host: URL { get }
    var networkSession: NetworkSession { get }
    
    func fetchEarthquakesData() async throws -> [Earthquake]
}

enum SeismicAPIClientError: Error {
    case invalidJSON
    case server
    case noInternet
    
    var localizedDescription: String {
        switch self {
        case .invalidJSON:
            return "You got some invalid JSON"
        case .server:
            return "There is some problem to the server"
        case .noInternet:
            return "It seems you have not internet. Please check it out"
        }
    }
}
