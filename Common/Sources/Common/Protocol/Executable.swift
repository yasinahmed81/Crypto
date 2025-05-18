//
//  Executable.swift
//  Common
//
//  Created by Yasin Ahmed on 16/05/2025.
//

public protocol Executable<Output>: Sendable {
    associatedtype Output
    func execute() async throws -> Output
}
