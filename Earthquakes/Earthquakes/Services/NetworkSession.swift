//
//  NetworkSession.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

protocol NetworkSession: AnyObject {
    func fetchData(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        return try await data(from: url)
    }
}
