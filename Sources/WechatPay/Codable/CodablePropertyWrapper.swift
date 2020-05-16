//
//  CodablePropertyWrapper.swift
//  
//
//  Created by xj on 2020/5/16.
//

import Foundation

@propertyWrapper
public final class Coda<Value> {
    public let name: String
    public var wrappedValue: Value
    
    public init(name: String, defaultValue: Value) {
        self.name = name
        self.wrappedValue = defaultValue
    }
}
