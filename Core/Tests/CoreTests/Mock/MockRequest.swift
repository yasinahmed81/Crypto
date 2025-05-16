//
//  MockRequest.swift
//  Core
//
//  Created by Yasin Ahmed on 16/05/2025.
//

import Foundation
@testable import Core

struct MockRequest: URLRequestFactoryMethod {
    var makeRequest: URLRequest {
        URLRequest(url: URL(string: "https://mock")!)
    }
}
