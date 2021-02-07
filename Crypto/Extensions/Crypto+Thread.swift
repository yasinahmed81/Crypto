//
//  Crypto+Thread.swift
//  Crypto
//
//  Created by Yasin Ahmed on 06/02/2021.
//

import Foundation

extension Thread {
    
    static func executeOnMain(_ execute: @escaping () -> Void) {
        handle(execute)
    }
    
    static func executeOnMain(_ execute: @autoclosure @escaping () -> Void) {
        handle(execute)
    }
    
    private static func handle(_ execute: @escaping () -> Void) {
        if current == main {
            execute()
        } else {
            DispatchQueue.main.async {
                execute()
            }
        }
    }
    
}
