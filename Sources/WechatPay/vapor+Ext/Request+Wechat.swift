//
//  File 2.swift
//  
//
//  Created by Spec on 2020/5/17.
//

import Vapor

extension Request {
    public var wechat: Wechat {
        .init(request: self)
    }
    
    public struct Wechat {
        let request: Request
        
        private var client: WxPayClient {
            self.request.application.wechat.client
        }
    }
}


// MARK: - User
extension Request.Wechat {
    
    func fetchUserAccessToken(_ code: String) throws -> EventLoopFuture<AccessTokenResp> {
        guard client.canAuth else { throw WxPayError(reason: "can not fetch user login access token") }
        
        return try client.fetchAuthAccessToken(code, req: request)
    }
    
    func getUserInfo(access token: String, openId: String) throws -> EventLoopFuture<WxUserInfo> {
        
        return try client.fetchAuthUserInfo(access: token, openId: openId, req: request)
    }
    
    func refresh(access token: String) throws -> EventLoopFuture<AccessTokenResp> {
        return try client.refreshAccessToken(refresh: token, req: request)
    }
    
    func valid(access token: String, openId: String) throws -> EventLoopFuture<CheckValidResp> {
        return try client.checkAccessTokenValid(access: token, openId: openId, req: request)
    }
}

// MARK: - Pay
extension Request.Wechat {
    
    func unified(order params: WxPayUnifiedOrderPramas) throws -> EventLoopFuture<WxPayAppReqParams> {
        guard client.canAuth else { throw WxPayError(reason: "can not unified order, maybe some key or secret not set") }
        return try client.unifiedOrder(params, req: request)
    }
    
    func query(order params: WxPayOrderQueryPramas) throws -> EventLoopFuture<WxPayOrderQueryResp> {
        guard client.canAuth else { throw WxPayError(reason: "can not query order, maybe some key or secret not set") }
        return try client.orderQuery(params, req: request)
    }
    
    func close(order params: WxPayCloseOrderParams) throws -> EventLoopFuture<WxPayCloseOrderResp> {
        guard client.canAuth else { throw WxPayError(reason: "can not close order, maybe some key or secret not set") }
        return try client.closeOrder(params, req: request)
    }
    
    func refund(order params: WxPayRefundOrderParams) throws -> EventLoopFuture<WxPayRefundOrderResp> {
        guard client.canAuth else { throw WxPayError(reason: "can not refund order, maybe some key or secret not set") }
        return try client.refundOrder(params, req: request)
    }
}
