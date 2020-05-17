//
//  File.swift
//  
//
//  Created by Spec on 2020/5/17.
//

import Vapor
import Coda

public struct WxUserInfo: Content {
    @Coda(name: "errcode", defaultValue: nil)
    public var errCode: Int?
    @Coda(name: "errmsg", defaultValue: nil)
    public var errMsg: String?
    @Coda(name: "openid", defaultValue: nil)
    public var openId: String?
    @Coda(name: "nickname", defaultValue: nil)
    public var nickName: String?
    @Coda(name: "sex", defaultValue: nil)
    public var sex: Int?
    @Coda(name: "language", defaultValue: nil)
    public var language: String?
    @Coda(name: "city", defaultValue: nil)
    public var city: String?
    @Coda(name: "province", defaultValue: nil)
    public var province: String?
    @Coda(name: "country", defaultValue: nil)
    public var country: String?
    @Coda(name: "headimgurl", defaultValue: nil)
    public var headImgUrl: String?
    @Coda(name: "privilege", defaultValue: nil)
    public var privilege: [String]?
    @Coda(name: "unionid", defaultValue: nil)
    public var unionId: String?
}

extension WxUserInfo: CodableModel {
    public init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}
