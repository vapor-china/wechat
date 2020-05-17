//
//  File.swift
//  
//
//  Created by Spec on 2020/5/17.
//

import Vapor
import Coda

struct AccessTokenReq: Content {
    @Coda(name: "appid", defaultValue: "")
    public var appId: String
    @Coda(name: "secret", defaultValue: "")
    public var secret: String
    @Coda(name: "code", defaultValue: "")
    public var code: String
    @Coda(name: "grant_type", defaultValue: "authorization_code")
    public var grantType: String
    
    init(appId: String, secret: String, code: String) {
        self.appId = appId
        self.secret = secret
        self.code = code
        
    }
}

extension AccessTokenReq: CodableModel {
    init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}
