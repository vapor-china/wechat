//
//  File.swift
//  
//
//  Created by Spec on 2020/5/16.
//

import Vapor
import Coda

public struct WxPayCallbackResp: Content, CodableModel {
    @Coda(name: "appid", defaultValue: "")
    public var appId: String
    @Coda(name: "mch_id", defaultValue: "")
    public var mchId: String
    @Coda(name: "device_info", defaultValue: nil)
    public var deviceInfo: String?
    @Coda(name: "nonce_str", defaultValue: "")
    public var nonceStr: String
    @Coda(name: "sign", defaultValue: "")
    public var sign: String
    @Coda(name: "sign_type", defaultValue: nil)
    public var signType: String?
    @Coda(name: "result_code", defaultValue: "")
    public var resultCode: String
    @Coda(name: "err_code", defaultValue: nil)
    public var errCode: String?
    @Coda(name: "err_code_des", defaultValue: nil)
    public var errMsg: String?
    @Coda(name: "openid", defaultValue: "")
    public var openId: String
    @Coda(name: "is_subscribe", defaultValue: "")
    public var isSubscribe: String
    @Coda(name: "trade_type", defaultValue: "")
    public var tradeType: String
    @Coda(name: "bank_type", defaultValue: "")
    public var bankType: String
    @Coda(name: "total_fee", defaultValue: 0)
    public var totalFee: Int
    @Coda(name: "settlement_total_fee", defaultValue: nil)
    public var settlementTotalFee: Int?
    @Coda(name: "fee_type", defaultValue: nil)
    public var feeType: String?
    @Coda(name: "cash_fee", defaultValue: 0)
    public var cashFee: Int
    @Coda(name: "cash_fee_type", defaultValue: nil)
    public var cashFeeType: String?
    @Coda(name: "coupon_fee", defaultValue: nil)
    public var couponFee: Int?
    @Coda(name: "coupon_count", defaultValue: nil)
    public var couponCount: Int?
    @Coda(name: "transaction_id", defaultValue: "")
    public var transactionId: String
    @Coda(name: "out_trade_no", defaultValue: "")
    public var outTradeNo: String
    @Coda(name: "attach", defaultValue: nil)
    public var attach: String?
    @Coda(name: "time_end", defaultValue: "")
    public var timeEnd: String

    
    @Coda(name: "return_code", defaultValue: "")
    public var returnCode: String
     @Coda(name: "return_msg", defaultValue: nil)
    public var returnMsg: String?
    
    public init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
    
}

extension WxPayCallbackResp {
    var SUCCESS_KEY: String { "SUCCESS" }
    var FAIL_KEY: String { "FAIL" }
}

extension WxPayCallbackResp {
    
    var isConnectSuccess: Bool {
        return returnCode == SUCCESS_KEY
    }
    var isTransactionSuccess: Bool {
        return resultCode == SUCCESS_KEY
    }
}
