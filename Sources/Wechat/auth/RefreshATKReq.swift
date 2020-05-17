//
//  File.swift
//  
//
//  Created by Spec on 2020/5/17.
//

import Vapor
import Coda

struct RefreshATKReq: Content {
    @Coda(name: "appid", defaultValue: "")
    var appId: String
    @Coda(name: "grant_type", defaultValue: "refresh_token")
    var grantType: String
    @Coda(name: "refresh_token", defaultValue: "")
    var refreshToken: String
    
    init(appId: String, refresh token: String) {
        self.appId = appId
        self.refreshToken = token
    }
}

extension RefreshATKReq: CodableModel {
    init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}
