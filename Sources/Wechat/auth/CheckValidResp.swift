//
//  File.swift
//  
//
//  Created by Spec on 2020/5/17.
//

import Vapor
import Coda

public struct CheckValidResp: Content {
    @Coda(name: "errcode", defaultValue: 0)
    public var errCode: Int
    @Coda(name: "errmsg", defaultValue: "")
    public var errMsg: String
}

extension CheckValidResp: CodableModel {
    public init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}
