//
//  HttpClientError.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

public enum HttpClientError: Error {
    case urlError(URLError)
    case unknownError(Error)
    case unexpectedURLResponse
    case decodingFailure(Error)
    case unexpectedStatusCodeReceived(Int)
}

extension HttpClientError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .urlError(let error):
            return "There was an error in the network request.\nReason: \(error.localizedDescription)"
        case .unknownError(let error):
            return "There was an unknown error in the network request.\nReason: \(error.localizedDescription)"
        case .unexpectedURLResponse:
            return "There was an unexpected response from the network request."
        case .decodingFailure(let error):
            return "The data received from the network request could not be decoded.\nReason: \(error.localizedDescription)"
        case .unexpectedStatusCodeReceived(let code):
            return "There was an unexpected status code that was received from the network request.\nHTTP status code was \(code)."
        }
    }
}
