//
//  util.swift
//  YucaBen
//
//  Created by Cihat Bostancı on 21.02.2021.
//

import Foundation


//Extension
extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    func toFloat() -> Float? {
        return NumberFormatter().number(from: self)?.floatValue
        }
}

enum Functionality {
    case allPurposeFunctionality
    case meterFunctionality
    case nonFunctionality
    case printingFunctionality
    case sideAndDeepFunctionality
}
