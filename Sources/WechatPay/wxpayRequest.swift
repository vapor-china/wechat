//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

extension WxpayClient {
    
    public func unifiedOrder(_ pramas: WxPayUnifiedOrderPramas, req: Request) throws -> EventLoopFuture<WxpayAppReqParams> {
        
        return try postWithParam(url: .unifiedorder, params: pramas, req: req).flatMapThrowing { res -> WxpayUnifiedOrderResponse in
            
            let result = try res.content.decode(WxpayUnifiedOrderResponse.self, using: XMLDecoder())
            if result.isSuccess {
                return result
            } else {
                throw WxpayError(reason: result.return_msg)
            }
            
        }.flatMapThrowing { (orderResult) -> (WxpayAppReqParams) in
            let timestamp = Int(Date().timeIntervalSince1970)
            var signParam = WxpayAppReqParams(appid: orderResult.appid, noncestr: orderResult.nonce_str, partnerid: orderResult.mch_id, prepayid: orderResult.prepay_id, timestamp: "\(timestamp)")
            let sign = try WxpaySign.sign(dic: MirrorExt.generateDic(model: signParam), key: self.apiKey, signType: self.signType).uppercased()
            signParam.sign = sign
            return signParam
        }
    }
    
    public func orderQuery(_ pramas: WxpayOrderQueryPramas, req: Request) throws -> EventLoopFuture<WxpayOrderQueryResp> {
        
        return try postWithParam(url: .orderquery, params: pramas, req: req).flatMapThrowing({ (resp) -> WxpayOrderQueryResp in
            let  result = try resp.content.decode(WxpayCallbackResp.self, using: XMLDecoder())
            
            
            // verfy sign
            if !result.isTransactionSuccess {
                throw WxpayError(reason: "wx pay order query failed")
            }
            
            if result.sign.isEmpty {
                throw WxpayError(reason: "verfy sign is empty")
            }
            
            let signDic = MirrorExt.generateDic(model: resp)
            let sign2 = try WxpaySign.sign(dic: signDic, key: self.apiKey, signType: self.signType)
            if result.sign != sign2 {
                throw WxpayError(reason: "verfy sign failed")
            }
            return result
        })
    }
    
}
