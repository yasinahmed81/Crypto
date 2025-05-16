//
//  Decodable+Decode.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

extension Decodable {
    static func decode(from data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
}
