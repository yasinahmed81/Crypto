//
//  NetworkError.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation

enum NetworkError: Error {
    
    case urlError(URLError)
    case noResponseReceived
    case noDataReceived
    case decodingFailure(DecodingError)
    case unexpectedResponse(code: Int)
}

extension NetworkError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .urlError(let error):
            return "There was an error in the network request.\nReason: \(error.localizedDescription)."
        case .noResponseReceived:
            return "There was no response received from the network request."
        case .noDataReceived:
            return "There was no data received from the network request."
        case .decodingFailure(let error):
            return "The data received from the network request could not be decoded.\nReason: \(error.localizedDescription)"
        case .unexpectedResponse(code: let code):
            return "There was an unexpected response from the network request.\nReason: HTTP status code was \(code)."
        }
    }
    
}
