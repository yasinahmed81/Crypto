//
//  MockURLSession.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation
@testable import Core

enum MockURLSessionCondition {
    case makeUnexpectedURLResponse
    case makeValidData
    case makeCorruptData
    case makeUnexpectedStatusCode
    case makeURLError
    case makeUnknownError
}

enum UnknownError: Error {
    case any
}

final class MockURLSession: URLSessionProtocol {
    let condition: MockURLSessionCondition
    
    init(condition: MockURLSessionCondition) {
        self.condition = condition
    }
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        switch condition {
        case .makeUnexpectedURLResponse:
            (try makeValidData(), makeUnexpectedURLResponse())
        case .makeValidData:
            (try makeValidData(), makeExpectedResponse())
        case .makeCorruptData:
            (try makeCorruptData(), makeExpectedResponse())
        case .makeUnexpectedStatusCode:
            (try makeValidData(), makeUnexpectedStatusCode())
        case .makeURLError:
            throw makeURLError()
        case .makeUnknownError:
            throw makeUnknownError()
        }
    }
    
    func makeUnexpectedURLResponse() -> URLResponse {
        URLResponse()
    }
    
    func makeValidData() throws -> Data {
        guard let url = Bundle.module.url(forResource: "ValidData", withExtension: "json") else {
            throw NSError(domain: "FileNotFound", code: 1, userInfo: nil)
            }
        return try Data(contentsOf: url)
    }
    
    func makeCorruptData() throws -> Data {
        guard let url = Bundle.module.url(forResource: "CorruptData", withExtension: "json") else {
            throw NSError(domain: "FileNotFound", code: 1, userInfo: nil)
            }
        return try Data(contentsOf: url)
    }
    
    func makeExpectedResponse() -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "http://-Mock-")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    func makeUnexpectedStatusCode() -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "http://-Mock-")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
    }
    
    func makeURLError() -> URLError {
        URLError(.notConnectedToInternet)
    }
    
    func makeUnknownError() -> Error {
        UnknownError.any
    }
}
