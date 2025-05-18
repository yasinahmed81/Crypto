//
//  Mapping.swift
//  Common
//
//  Created by Yasin Ahmed on 16/05/2025.
//

public protocol Mapping<Input, Output>: Sendable {
    associatedtype Input
    associatedtype Output
    func map(_ input: Input) -> Output
}
