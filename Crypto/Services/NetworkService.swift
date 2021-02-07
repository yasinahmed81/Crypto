//
//  NetworkService.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation

final class NetworkService: Resourcable {
    
    private let session: URLSessionProtocol
    private let shouldExecuteCallbackOnMainThread: Bool
    
    init(session: URLSessionProtocol = URLSession.configured, shouldExecuteCallbackOnMainThread: Bool = true) {
        self.session = session
        self.shouldExecuteCallbackOnMainThread = shouldExecuteCallbackOnMainThread
    }
    
    func request<Model: Decodable>(_ factory: URLRequestFactory, decodingModel: Model.Type, completion: @escaping (Result<Model, NetworkError>) -> Void) {
        
        let task = session.dataTask(with: factory.makeRequest) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard self.shouldExecuteCallbackOnMainThread else { self.processCallback(with: data, response: response, error: error, completion: completion); return }
            Thread.executeOnMain(self.processCallback(with: data, response: response, error: error, completion: completion))
        }
        
        task.resume()
    }
    
}

extension NetworkService {
    
    private func processCallback<Model: Decodable>(with data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Model, NetworkError>) -> Void) {
        
        if let error = error as? URLError {
            completion(.failure(.urlError(error)))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(.noResponseReceived))
            return
        }
        
        guard let data = data else {
            completion(.failure(.noDataReceived))
            return
        }
        
        switch response.statusCode {
        case 200 ..< 300:
            do {
                let model = try Model.decode(from: data)
                completion(.success(model))
            } catch let error as DecodingError {
                completion(.failure(.decodingFailure(error)))
            } catch {
                assertionFailure("Decoding errors should be caught by now.")
            }
        default:
            completion(.failure(.unexpectedResponse(code: response.statusCode)))
        }
        
    }
    
}
