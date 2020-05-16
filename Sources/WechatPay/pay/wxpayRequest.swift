//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

extension WxPayClient {
    
    // 统一下单
    public func unifiedOrder(_ pramas: WxPayUnifiedOrderPramas, req: Request) throws -> EventLoopFuture<WxPayAppReqParams> {
        
        return try postWithParam(url: .unifiedOrder, params: pramas, req: req).flatMapThrowing { res -> WxPayUnifiedOrderResponse in
            
            let result = try res.content.decode(WxPayUnifiedOrderResponse.self, using: XMLDecoder())
            if result.isSuccess {
                return result
            } else {
                throw WxPayError(reason: result.returnMsg)
            }
            
        }.flatMapThrowing { (orderResult) -> (WxPayAppReqParams) in
            let timestamp = Int(Date().timeIntervalSince1970)
            var signParam = WxPayAppReqParams(appid: orderResult.appId, noncestr: orderResult.nonceStr, partnerid: orderResult.mchId, prepayid: orderResult.prepayId, timestamp: "\(timestamp)")
            let sign = try WxPaySign.sign(dic: MirrorExt.generateDic(model: signParam), key: self.mchSecret, signType: self.signType).uppercased()
            signParam.sign = sign
            return signParam
        }
    }
    // 订单查询
    public func orderQuery(_ pramas: WxPayOrderQueryPramas, req: Request) throws -> EventLoopFuture<WxPayOrderQueryResp> {
        
        return try postWithParam(url: .orderQuery, params: pramas, req: req).flatMapThrowing({ (resp) -> WxPayOrderQueryResp in
            let  result = try resp.content.decode(WxPayCallbackResp.self, using: XMLDecoder())
            
            
            // verfy sign
            if !result.isTransactionSuccess {
                throw WxPayError(reason: "wx pay order query failed")
            }
            
            if result.sign.isEmpty {
                throw WxPayError(reason: "verfy sign is empty")
            }
            
            let signDic = MirrorExt.generateDic(model: resp)
            let sign2 = try WxPaySign.sign(dic: signDic, key: self.mchSecret, signType: self.signType)
            if result.sign != sign2 {
                throw WxPayError(reason: "verfy sign failed")
            }
            return result
        })
    }
    // 关闭订单
    public func closeOrder(_ params: WxPayCloseOrderParams, req: Request) throws -> EventLoopFuture<WxPayCloseOrderResp> {
        
        return try postWithParam(url: .closeOrder, params: params, req: req).flatMapThrowing { (resp) -> WxPayCloseOrderResp in
            
            let result = try resp.content.decode(WxPayCloseOrderResp.self, using: XMLDecoder())
            
            if result.sign.isEmpty {
                throw WxPayError(reason: "verfy sign is empty")
            }
            
            let signDic = MirrorExt.generateDic(model: resp)
            let sign2 = try WxPaySign.sign(dic: signDic, key: self.mchSecret, signType: self.signType)
            if result.sign != sign2 {
                throw WxPayError(reason: "verfy sign failed")
            }
            return result
        }
    }
    // 退款
    public func refundOrder(_ params: WxPayRefundOrderParams, req: Request) throws -> EventLoopFuture<WxPayRefundOrderResp> {
        
        return try postWithParam(url: .refundOrder, params: params, req: req).flatMapThrowing({ (resp) -> WxPayRefundOrderResp in
            
            let result = try resp.content.decode(WxPayRefundOrderResp.self, using: XMLDecoder())
            
            if result.sign.isEmpty {
                throw WxPayError(reason: "verfy sign is empty")
            }
            
            let signDic = MirrorExt.generateDic(model: resp)
            let sign2 = try WxPaySign.sign(dic: signDic, key: self.mchSecret, signType: self.signType)
            if result.sign != sign2 {
                throw WxPayError(reason: "verfy sign failed")
            }
            return result
        })
    }
}
