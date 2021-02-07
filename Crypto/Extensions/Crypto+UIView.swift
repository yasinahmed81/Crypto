//
//  Crypto+UIView.swift
//  Crypto
//
//  Created by Yasin Ahmed on 07/02/2021.
//

import UIKit

extension UIView {
    
    var addRoundCorners: Void {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    var addShadow: Void {
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = CGSize(width: 0.2, height: 0.4)
        layer.shadowOpacity = 0.20
        layer.shadowRadius = 8.0
    }
    
    private var cornerRadius: CGFloat {
        return 8.0
    }
    
}
