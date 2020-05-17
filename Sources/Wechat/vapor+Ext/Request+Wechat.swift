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
    
    public func fetchUserAccessToken(_ code: String) throws -> EventLoopFuture<AccessTokenResp> {
        guard client.canAuth else { throw WxPayError(reason: client.canAuthErrMsg) }
        
        return try client.fetchAuthAccessToken(code, req: request)
    }
    
    public func getUserInfo(access token: String, openId: String) throws -> EventLoopFuture<WxUserInfo> {
        
        return try client.fetchAuthUserInfo(access: token, openId: openId, req: request)
    }
    
    public func refresh(access token: String) throws -> EventLoopFuture<AccessTokenResp> {
        return try client.refreshAccessToken(refresh: token, req: request)
    }
    
    public func valid(access token: String, openId: String) throws -> EventLoopFuture<CheckValidResp> {
        return try client.checkAccessTokenValid(access: token, openId: openId, req: request)
    }
}

// MARK: - Pay
extension Request.Wechat {
    
    public func unified(order params: WxPayUnifiedOrderPramas) throws -> EventLoopFuture<WxPayAppReqParams> {
        guard client.canAuth else { throw WxPayError(reason: "can not unified order, \(client.canPayErrMsg)") }
        return try client.unifiedOrder(params, req: request)
    }
    
    public func query(order params: WxPayOrderQueryPramas) throws -> EventLoopFuture<WxPayOrderQueryResp> {
        guard client.canAuth else { throw WxPayError(reason: "can not query order, \(client.canPayErrMsg)") }
        return try client.orderQuery(params, req: request)
    }
    
    public func close(order params: WxPayCloseOrderParams) throws -> EventLoopFuture<WxPayCloseOrderResp> {
        guard client.canAuth else { throw WxPayError(reason: "can not close order, \(client.canPayErrMsg)") }
        return try client.closeOrder(params, req: request)
    }
    
    public func refund(order params: WxPayRefundOrderParams) throws -> EventLoopFuture<WxPayRefundOrderResp> {
        guard client.canAuth else { throw WxPayError(reason: "can not refund order, \(client.canPayErrMsg)") }
        return try client.refundOrder(params, req: request)
    }
}


extension Request.Wechat {
    public func payCallback() throws -> WxPayCallbackResp {
        
        return try client.dealwithCallback(req: request)
    }
}
