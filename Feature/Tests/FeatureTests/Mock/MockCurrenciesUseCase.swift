//
//  MockCurrenciesUseCase.swift
//  Feature
//
//  Created by Yasin Ahmed on 18/05/2025.
//

import Common
@testable import UseCase

enum MockCurrenciesUseCaseCondition {
    case success
    case error
}

enum UnknownError: Error {
    case any
}

final class MockCurrenciesUseCase: Executable {
    
    let condition: MockCurrenciesUseCaseCondition
    
    init(condition: MockCurrenciesUseCaseCondition) {
        self.condition = condition
    }
    
    func execute() async throws -> CurrenciesViewState {
        switch condition {
        case .success:
            return MockCurrenciesViewState.makeState()
        case .error:
            throw UnknownError.any
        }
    }
}
