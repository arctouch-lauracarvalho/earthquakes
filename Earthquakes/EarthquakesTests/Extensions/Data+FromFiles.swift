//
//  Data+FromFiles.swift
//  EarthquakesTests
//
//  Created by Laura Carvalho on 04/06/24.
//

import Foundation
import XCTest

extension Data {
    static func fromJSON(fileName: String) throws -> Data {
        return try from(fileName: fileName, withExtension: "json")
    }
    
    private static func from(fileName: String,
                             withExtension fileExtension: String,
                             file: StaticString = #file,
                             line: UInt = #line) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let url = try XCTUnwrap(bundle.url(forResource: fileName, withExtension: fileExtension),
                                "Unable to find \(fileName).json. Verify if files has been added to the Test bundle.",
                                file: file, line: line)
        return try Data(contentsOf: url)
    }
}

private class TestBundleClass {}
