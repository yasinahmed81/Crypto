//
//  URLSessionProtocol.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

// Retroactive modelling to aid unit tests
public protocol URLSessionProtocol {
    func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
