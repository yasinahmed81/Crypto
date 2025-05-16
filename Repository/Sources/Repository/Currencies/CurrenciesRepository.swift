//
//  CurrenciesRepository.swift
//  Repository
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Core
import Common

public class CurrenciesRepository: Executable {
    let service: Resourcable
    let mapper: any Mapping<CurrenciesDataContainer, CurrenciesEntityContainer>
    
    public init(
        service: Resourcable = HttpClient(),
        mapper: any Mapping<CurrenciesDataContainer, CurrenciesEntityContainer> = CurrenciesMapper()
    ) {
        self.service = service
        self.mapper = mapper
    }
    
    public func execute() async throws -> CurrenciesEntityContainer {
        let data = try await service.request(Request.cryptoCurrencies, decodingModel: CurrenciesDataContainer.self)
        return mapper.map(data)
    }
}
