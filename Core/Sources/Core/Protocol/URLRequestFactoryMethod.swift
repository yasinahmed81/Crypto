//
//  URLRequestable.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

public protocol URLRequestFactoryMethod {
    var makeRequest: URLRequest { get }
}
