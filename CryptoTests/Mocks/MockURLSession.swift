//
//  MockURLSession.swift
//  CryptoTests
//
//  Created by Yasin Ahmed on 08/02/2021.
//

@testable import Crypto
import Foundation

final class MockURLSession: URLSessionProtocol {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return MockURLSessionDataTask {
            completionHandler(self.data, self.response, self.error)
        }
    }
    
    func makeCoinsData() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "Coins", ofType: "json") else { return }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
        self.data = data
    }
    
    func makeCorruptData() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "CorruptData", ofType: "json") else { return }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
        self.data = data
    }
    
    func makeExpectedResponse() {
        response = HTTPURLResponse(url: URL(string: "http://-Mock-")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    }
    
    func makeUnexpectedResponse() {
        response = HTTPURLResponse(url: URL(string: "http://-Mock-")!, statusCode: 404, httpVersion: nil, headerFields: nil)
    }
    
    func makeError() {
        let networkError = URLError(.notConnectedToInternet)
        error = networkError
    }
    
}

extension MockURLSession {
 
    final class MockURLSessionDataTask: URLSessionDataTask, @unchecked Sendable {
        
        private let closure: () -> Void
        
        init(closure: @escaping () -> Void) {
            self.closure = closure
        }
        
        override func resume() {
            closure()
        }
    }
    
}
