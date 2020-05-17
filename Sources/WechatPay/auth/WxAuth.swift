//
//  File.swift
//  
//
//  Created by xj on 2020/5/15.
//

import Vapor


extension WxPayClient {
    
    public func FetchAuthAccessToken(_ code: String, req: Request) throws -> EventLoopFuture<AccessTokenResp> {
        
        let txAuthReq = AccessTokenReq(appId: appId, secret: appSecret, code: code)
        
         return req.client.get(URI(string: WxPayConst.Url.oauth2Access.str)) { (req) in
            try req.query.encode(txAuthReq)
         }.flatMapThrowing { (resp) in
            
            return try resp.content.decode(AccessTokenResp.self, using: JSONDecoder())
        }
    
    }
    
    
    
    public func FetchAuthUserInfo(access token: String, openId: String, req: Request) throws -> EventLoopFuture<WxUserInfo> {
        
        let txAuthReq = AuthATKOpenIdReq(accessToken: token, openId: openId)
        return req.client.get(URI(string: WxPayConst.Url.userInfo.str)) { (req) in
            try req.query.encode(txAuthReq)
         }.flatMapThrowing { (resp) -> WxUserInfo in
            return try resp.content.decode(WxUserInfo.self, using: JSONDecoder())
        }
    }
    
    
    
    public func refreshAccessToken(refresh token: String, req: Request) throws -> EventLoopFuture<AccessTokenResp> {
        let refreshReq = RefreshATKReq(appId: appId, refresh: token)
        
        return req.client.get(URI(string: WxPayConst.Url.refreshATk.str)) { req in
            try req.query.encode(refreshReq)
        }.flatMapThrowing { (resp) -> AccessTokenResp in
            return try resp.content.decode(AccessTokenResp.self, using: JSONDecoder())
        }
    }
    
    public func checkAccessTokenValid(access token: String, openId: String, req: Request) throws -> EventLoopFuture<CheckValidResp> {
        let txAuthReq = AuthATKOpenIdReq(accessToken: token, openId: openId)
        return req.client.get(URI(string: WxPayConst.Url.checkATK.str)) { req in
            try req.query.encode(txAuthReq)
        }.flatMapThrowing { (resp) in
            return try resp.content.decode(CheckValidResp.self, using: JSONDecoder())
        }
    }
}





