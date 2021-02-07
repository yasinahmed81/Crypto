//
//  Crypto+Decodable.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation

extension Decodable {
    
    static func decode(from data: Data) throws -> Self {
    
        return try JSONDecoder().decode(Self.self, from: data)
    }
}
