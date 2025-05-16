//
//  HttpClient+Configured.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

extension URLSession {
    public static var configured: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.urlCache = nil
        return URLSession(configuration: configuration)
    }
}
