//
//  EarthquakesClient.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

final class EarthquakesClient: SeismicAPIClient {
    let host: URL
    let networkSession: NetworkSession
    
    init(host: URL, networkSession: NetworkSession) {
        self.host = host
        self.networkSession = networkSession
    }
    
    func fetchEarthquakesData() async throws -> [Earthquake] {
        let task = Task {
            do {
                let (data, response) = try await networkSession.fetchData(from: host)
                let earthquakesList = try handleResponse(data: data, response: response)
                return earthquakesList
            } catch {
                if (error as? URLError)?.code == URLError.notConnectedToInternet {
                    throw SeismicAPIClientError.noInternet
                }
                
                if (error as? DecodingError) != nil {
                    throw SeismicAPIClientError.invalidJSON
                }
                
                throw SeismicAPIClientError.server
            }
        }
        
        return try await task.value
    }
}

// MARK: - Private Methods
private extension EarthquakesClient {
    private func handleResponse(data: Data, response: URLResponse) throws -> [Earthquake] {
        guard isSuccessResponse(response) else {
            throw SeismicAPIClientError.server
        }
        
        let decoder = JSONDecoder()
        let decodedResult = try decoder.decode(EarthquakeResponse.self, from: data)
        let earthquakesList = decodedResult.features
        return earthquakesList
    }
    
    private func isSuccessResponse(_ response: URLResponse) -> Bool {
        guard let validResponse = response as? HTTPURLResponse, validResponse.statusCode == 200 else {
            return false
        }
        return true
    }
}
