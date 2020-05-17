//
//  File.swift
//  
//
//  Created by Spec on 2020/5/17.
//

import Vapor
import Coda

struct AuthATKOpenIdReq: Content {
    @Coda(name: "access_token", defaultValue: "")
    public var accessToken: String
    @Coda(name: "openid", defaultValue: "")
    public var openId: String
    
    init(accessToken: String, openId: String) {
        self.accessToken = accessToken
        self.openId = openId
    }
}
extension AuthATKOpenIdReq: CodableModel {
    init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}
