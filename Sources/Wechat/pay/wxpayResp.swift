//
//  File.swift
//  
//
//  Created by xj on 2020/4/2.
//

import Vapor
import Coda

struct WxPayUnifiedOrderResponse: Content, CodableModel {
    @Coda(name: "return_code", defaultValue: "")
    public var returnCode: String
    @Coda(name: "return_msg", defaultValue: "")
    public var returnMsg: String
    @Coda(name: "appid", defaultValue: "")
    public var appId: String
    @Coda(name: "mch_id", defaultValue: "")
    public var mchId: String
    @Coda(name: "nonce_str", defaultValue: "")
    public var nonceStr: String
    @Coda(name: "sign", defaultValue: "")
    public var sign: String
    @Coda(name: "result_code", defaultValue: "")
    public var resultCode: String
    @Coda(name: "prepay_id", defaultValue: "")
    public var prepayId: String
    @Coda(name: "trade_type", defaultValue: "")
    public var tradeType: String
    
    init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}

extension WxPayUnifiedOrderResponse {
    
    var isSuccess: Bool {
        return resultCode == "SUCCESS"
    }
}
