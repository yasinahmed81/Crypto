//
//  URLRequestable.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation

protocol URLRequestFactoryMethod {
    var makeRequest: URLRequest { get }
}
