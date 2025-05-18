//
//  AlertPresentable.swift
//  Crypto
//
//  Created by Yasin Ahmed on 07/02/2021.
//

import UIKit

protocol AlertPresentable {
    @MainActor
    func presentAlert(title: String, body: String, retry: (@Sendable () -> Void)?)
}

extension AlertPresentable where Self: UIViewController {
    
    @MainActor
    func presentAlert(title: String = "Uh-oh!", body: String, retry:(@Sendable () -> Void)?) {
        let ac = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let retry = UIAlertAction(title: "Retry", style: .default) { _ in
            retry?()
        }
        ac.addAction(cancel)
        ac.addAction(retry)
        ac.preferredAction = retry
        present(ac, animated: true, completion: nil)
    }

}
