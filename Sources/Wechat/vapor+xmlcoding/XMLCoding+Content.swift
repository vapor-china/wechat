//
//  File.swift
//  
//
//  Created by xj on 2020/4/3.
//

import Vapor


extension XMLDecoder: ContentDecoder {
    
    public func decode<D>(_ decodable: D.Type, from body: ByteBuffer, headers: HTTPHeaders) throws -> D where D : Decodable {
        guard headers.contentType == .xml || headers.contentType == .plainText || headers.contentType == HTTPMediaType(type: "text", subType: "xml") else {
            throw Abort(.unsupportedMediaType)
        }
        let data = body.getData(at: body.readerIndex, length: body.readableBytes) ?? Data()
        return try self.decode(D.self, from: data)
    }
}

extension XMLEncoder: ContentEncoder {
    
    public func encode<E>(_ encodable: E, to body: inout ByteBuffer, headers: inout HTTPHeaders) throws where E : Encodable {
        headers.contentType = .xml
        try body.writeBytes(self.encode(encodable, withRootKey: "xml"))
    }
}
