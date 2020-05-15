//
//  File.swift
//  
//
//  Created by xj on 2020/5/15.
//

import Vapor

struct AccessTokenReq: Content {
       let appid: String
       let secret: String
       let code: String
       let grant_type: String = "authorization_code"
   }
   
   public struct AccessTokenResp: Content {
       let access_token: String?
       let expires_in: Int?
       let refresh_token: String?
       let openid: String?
       public let scope: String?
       let unionid: String?
    
        let errcode: Int?
        let errmsg: String?
    
    public var accessToken: String? { access_token }
    
    public var openID: String? { openid }
    
    public var refreshToken: String? { refresh_token }
    
    public var unionID: String? { unionid }
    
    public var exporesIn: Int? { expires_in }
    
    public var isErrMsg: String? {
        
        guard let code = errcode else { return nil }
        switch code {
        case 40125: return "app secret 不正确"
        case 40029: return "无效的code"
        case 40163: return "code已经被使用了"
        default: return errmsg ?? "未知错误"
        }
    }
   }

extension WxPayClient {
    
    public func FetchAuthAccessToken(_ code: String, req: Request) throws -> EventLoopFuture<AccessTokenResp> {
        
        let txAuthReq = AccessTokenReq(appid: appId, secret: appSecret, code: code)
        
         return req.client.get(URI(string: WxPayConst.Url.oauth2Access.str)) { (req) in
            try req.query.encode(txAuthReq)
         }.flatMapThrowing { (resp) in
            
            return try resp.content.decode(AccessTokenResp.self, using: JSONDecoder())
        }
    
    }
    
    struct AuthATKOpenidReq: Content {
        let access_token: String
        let openid: String
    }
    
    public func FetchAuthUserInfo(access token: String, openId: String, req: Request) throws -> EventLoopFuture<WxUserInfo> {
        
        let txAuthReq = AuthATKOpenidReq(access_token: token, openid: openId)
        return req.client.get(URI(string: WxPayConst.Url.userInfo.str)) { (req) in
            try req.query.encode(txAuthReq)
         }.flatMapThrowing { (resp) -> WxUserInfo in
            return try resp.content.decode(WxUserInfo.self, using: JSONDecoder())
        }
    }
    
    struct RefreshATKReq: Content {
        let appid: String
        let grant_type: String = "refresh_token"
        let refresh_token: String
    }
    
    public func refreshAccessToken(refresh token: String, req: Request) throws -> EventLoopFuture<AccessTokenResp> {
        let refreshReq = RefreshATKReq(appid: appId, refresh_token: token)
        
        return req.client.get(URI(string: WxPayConst.Url.refreshATk.str)) { req in
            try req.query.encode(refreshReq)
        }.flatMapThrowing { (resp) -> AccessTokenResp in
            return try resp.content.decode(AccessTokenResp.self, using: JSONDecoder())
        }
    }
    
    public func checkAccessTokenValid(access token: String, openId: String, req: Request) throws -> EventLoopFuture<CheckValidResp> {
        let txAuthReq = AuthATKOpenidReq(access_token: token, openid: openId)
        return req.client.get(URI(string: WxPayConst.Url.checkATK.str)) { req in
            try req.query.encode(txAuthReq)
        }.flatMapThrowing { (resp) in
            return try resp.content.decode(CheckValidResp.self, using: JSONDecoder())
        }
    }
}

public struct CheckValidResp: Content {
    let errcode: Int
    let errmsg: String
}


public struct WxUserInfo: Content {
    let errcode: Int?
    let errmsg: String?
    
    let openid: String?
    let nickname: String?
    let sex: Int?
    let language: String?
    let city: String?
    let province: String?
    let country: String?
    let headimgurl: String?
    let privilege: [String]?
    let unionid: String
}
