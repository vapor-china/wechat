//
//  File.swift
//  
//
//  Created by xj on 2020/5/16.
//

import Foundation

/*
private protocol EncodeProtocol {
    typealias Container = KeyedEncodingContainer<CodaKey>
    func encodeValue(from container: inout Container) throws
}
extension Coda: EncodeProtocol where Value: Encodable {

     fileprivate func encodeValue(from container: inout Container) throws {
        
        let key = CodaKey(name: name)
        
        try container.encode(wrappedValue, forKey: key)
    }
}
extension CadableModel where Self: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodaKey.self)

        for child in Mirror(reflecting: self).children {

            guard let flag = child.value as? EncodeProtocol else {
                continue
            }
            try flag.encodeValue(from: &container)
        }
    }
}
*/
