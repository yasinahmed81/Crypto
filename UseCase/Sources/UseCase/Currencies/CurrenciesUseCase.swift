//
//  CurrenciesRepository.swift
//  UseCase
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Repository
import Common

public final class CurrenciesUseCase: Executable {
    let repository: any Executable<CurrenciesEntityContainer>
    let mapper: any Mapping<CurrenciesEntityContainer, CurrenciesViewState>
    
    public init(
        repository: any Executable<CurrenciesEntityContainer> = CurrenciesRepository(),
        mapper: any Mapping<CurrenciesEntityContainer, CurrenciesViewState> = CurrenciesMapper()
    ) {
        self.repository = repository
        self.mapper = mapper
    }
    
    public func execute() async throws -> CurrenciesViewState {
        let entity = try await repository.execute()
        return mapper.map(entity)
    }
}
