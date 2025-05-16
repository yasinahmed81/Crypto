//
//  Resourcable.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

public protocol Resourcable {
    /// Makes a request to an endpoint and then provides a decoded `Model`
    ///
    /// - Parameters:
    ///   - factory: Takes a `URLRequestFactoryMethod` type
    ///   - decodingModel: The `Decodable` `Model` to use when decoding the `data` received from the endpoint
    /// - Throws: `HttpClientError`
    /// - Returns: A decoded `Model`
    func request<Model: Decodable>(
        _ factory: URLRequestFactoryMethod,
        decodingModel: Model.Type
    ) async throws(HttpClientError) -> Model
}
