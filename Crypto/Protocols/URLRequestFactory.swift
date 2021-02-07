//
//  URLRequestFactory.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation

protocol URLRequestFactory {
    var makeRequest: URLRequest { get }
}
