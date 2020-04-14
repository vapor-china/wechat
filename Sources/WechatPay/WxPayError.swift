//
//  File.swift
//  
//
//  Created by xj on 2020/4/14.
//

import Foundation

public struct WxPayError: Error {
    
    var reason: String
    
    init(reason: String) {
        self.reason = reason
    }
    
}

extension WxPayError: CustomStringConvertible {
    public var description: String {
        return "the reason is: \(reason)"
    }
}
