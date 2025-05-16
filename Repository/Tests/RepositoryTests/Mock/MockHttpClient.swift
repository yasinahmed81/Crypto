//
//  MockHttpClient.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Core

enum MockHttpClientCondition {
    case success
    case error
}

final class MockHttpClient: Resourcable {
    let condition: MockHttpClientCondition
    
    init(condition: MockHttpClientCondition) {
        self.condition = condition
    }
    
    func request<Model>(_ factory: any Core.URLRequestFactoryMethod, decodingModel: Model.Type) async throws(Core.HttpClientError) -> Model where Model : Decodable {
        switch condition {
        case .success:
            return MockCurrenciesDataContainer.makeContainer() as! Model // Force unwrapping is ok in a Mock
        case .error:
            throw HttpClientError.unexpectedURLResponse
        }
    }
}
