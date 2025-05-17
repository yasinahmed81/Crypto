//
//  MockHttpClient.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Common
@testable import Repository

enum MockCurrenciesRepositoryCondition {
    case success
    case error
}

enum UnknownError: Error {
    case any
}

final class MockCurrenciesRepository: Executable {
    
    let condition: MockCurrenciesRepositoryCondition
    
    init(condition: MockCurrenciesRepositoryCondition) {
        self.condition = condition
    }
    
    func execute() async throws -> CurrenciesEntityContainer {
        switch condition {
        case .success:
            return MockCurrenciesEntityContainer.makeContainer()
        case .error:
            throw UnknownError.any
        }
    }
}
