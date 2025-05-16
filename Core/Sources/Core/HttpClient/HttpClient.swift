//
//  HttpClient.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

final class HttpClient: Resourcable {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.configured) {
        self.session = session
    }
    
    func request<Model: Decodable>(
        _ factory: any URLRequestFactoryMethod,
        decodingModel: Model.Type
    ) async throws(HttpClientError) -> Model {
        do {
            let (data, response) = try await session.data(for: factory.makeRequest, delegate: nil)
            
            guard let response = response as? HTTPURLResponse else {
                throw HttpClientError.unexpectedURLResponse
            }
            
            switch response.statusCode {
            case 200 ..< 300:
                do {
                    return try Model.decode(from: data)
                } catch {
                    throw HttpClientError.decodingFailure(error)
                }
            default:
                throw HttpClientError.unexpectedStatusCodeReceived(response.statusCode)
            }
        } catch {
            if let error = error as? URLError {
                throw HttpClientError.urlError(error)
            }
            
            if let error = error as? HttpClientError {
                throw error
            }
            
            throw HttpClientError.unknownError(error)
        }
    }
}
