//
//  File.swift
//  
//
//  Created by Spec on 2020/5/17.
//

import Vapor
import Coda

public struct AccessTokenResp: Content {
    @Coda(name: "access_token", defaultValue: nil)
    public var accessToken: String?
    @Coda(name: "expires_in", defaultValue: nil)
    public var expiresIn: Int?
    @Coda(name: "refresh_token", defaultValue: nil)
    public var refreshToken: String?
    @Coda(name: "openid", defaultValue: nil)
    public var openId: String?
    @Coda(name: "scope", defaultValue: nil)
    public var scope: String?
    @Coda(name: "unionid", defaultValue: nil)
    public var unionId: String?
    @Coda(name: "errcode", defaultValue: nil)
    public var errCode: Int?
    @Coda(name: "errmsg", defaultValue: nil)
    public var errMsg: String?
    
    
    public var isErrMsg: String? {
        
        guard let code = errCode else { return nil }
        switch code {
        case 40125: return "app secret 不正确"
        case 40029: return "无效的code"
        case 40163: return "code已经被使用了"
        default: return errMsg ?? "未知错误"
        }
    }
}
extension AccessTokenResp: CodableModel {
    public init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}
