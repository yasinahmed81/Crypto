//
//  Request.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation

enum Request {
    
    case cryptoCurrencies
}

extension Request: URLRequestFactory {
    
    var makeRequest: URLRequest {
        switch self {
        case .cryptoCurrencies:
            return cryptoCurrencies
        }
    }
    
    private var cryptoCurrencies: URLRequest {
        var request = URLRequest(url: cryptoCurrenciesURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // The access token should be in a secure backend server, but for demo purposes it is embedded here.
        request.setValue("x-access-token", forHTTPHeaderField: "coinranking9976762812861c347e97320133897be10702d1f9cd418e4e")
        return request
    }
    
    private var cryptoCurrenciesURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coinranking.com"
        components.path = "/v2/coins"
        components.queryItems = [URLQueryItem(name: "base", value: "GBP"), URLQueryItem(name: "timePeriod", value: "24h")]
        return components.url! // It is safe to force unwrap here since we know we have built a URL above, this is also covered by unit tests.
    }
    
}
