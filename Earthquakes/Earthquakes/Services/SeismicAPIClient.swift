//
//  SeismicAPIClient.swift
//  Earthquakes
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation

protocol SeismicAPIClient: AnyObject {
    var host: URL { get }
    var networkSession: URLSession { get }
}
