//
//  Resourcable.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation

protocol Resourcable {
    
    /// Makes a request to an endpoint and then provides a `Result`.
    ///
    /// - Parameters:
    ///   - factory: Takes a `URLRequestFactory` type.
    ///   - decodingModel: The `Decodable` model to use when decoding the `data` received from the endpoint.
    ///   - completion: Provides a `Result` type containing
    ///                 either a decoded `Model` or a `NetworkError`.
    func request<Model: Decodable>(_ factory: URLRequestFactory, decodingModel: Model.Type, completion: @escaping (Result<Model, NetworkError>) -> Void)
}
