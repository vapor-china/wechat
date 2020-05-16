//
//  File.swift
//  
//
//  Created by xj on 2020/5/16.
//

import Foundation

struct CodaKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init(name: String) {
        stringValue = name
    }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
    
}
