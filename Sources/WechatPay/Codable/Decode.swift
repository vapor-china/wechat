//
//  File.swift
//  
//
//  Created by xj on 2020/5/16.
//

import Foundation
import Vapor

protocol CodableProtocol {
    typealias DecodeContainer = KeyedDecodingContainer<CodaKey>
    typealias EncodeContainer = KeyedEncodingContainer<CodaKey>
    func decodeValue(from container: DecodeContainer) throws
    func encodeValue(from container: inout EncodeContainer) throws
}

extension Coda: CodableProtocol where Value: Codable {
    
    func decodeValue(from container: DecodeContainer) throws {
        let key = CodaKey(name: name)
        if let value = try container.decodeIfPresent(Value.self, forKey: key) {
            wrappedValue = value
        }
    }
    
    func encodeValue(from container: inout EncodeContainer) throws {
        
        let key = CodaKey(name: name)
        
        try container.encode(wrappedValue, forKey: key)
    }
}

extension CodableModel where Self: Codable {
    public func deco(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodaKey.self)
        for child in Mirror(reflecting: self).children {
            guard let flag = child.value as? CodableProtocol else {
                continue
            }
            try flag.decodeValue(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodaKey.self)

        for child in Mirror(reflecting: self).children {

            guard let flag = child.value as? CodableProtocol else {
                continue
            }
            try flag.encodeValue(from: &container)
        }
    }
}

/*
private protocol DecodeProtocol {
    typealias Container = KeyedDecodingContainer<CodaKey>
    func decodeValue(from container: Container) throws
}

extension Coda: DecodeProtocol where Value: Decodable {
    fileprivate func decodeValue(from container: Container) throws {
        let key = CodaKey(name: name)
        if let value = try container.decodeIfPresent(Value.self, forKey: key) {
            wrappedValue = value
        }
    }
}

extension CadableModel where Self: Decodable {
    
    func deco(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodaKey.self)
        for child in Mirror(reflecting: self).children {
            guard let flag = child.value as? DecodableFlag else {
                continue
            }
            try flag.decodeValue(from: container)
        }
    }
}
*/
