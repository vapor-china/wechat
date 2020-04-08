//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

public class WxpayOrderQueryPramas: WxParams {
    public init(transaction_id: String? = nil, out_trade_no: String? = nil) {
        self.transaction_id = transaction_id
        self.out_trade_no = out_trade_no
    }
    
    var transaction_id: String?
    var out_trade_no: String?
}


public typealias WxpayOrderQueryResp = WxpayCallbackResp
/*
public struct WxpayOrderQueryResp: Content {
    let return_code: String
    let return_msg: String?
    
    let appid: String
    let mch_id: String
    let nonce_str: String
    let sign: String
    let result_code: String
    let err_code: String?
    let err_code_des: String?
    
    let device_info: String?
    let openid: String
    let is_subscribe: String
    let trade_type: String
    let trade_state: String
    let bank_type: String
    let total_fee: String
    let fee_type: String
    let cash_fee: String
    let cash_fee_type: String
    let settlement_total_fee: String
    let coupon_fee: String
    let return_code: String
    let return_code: String
    let return_code: String
    let return_code: String
    let return_code: String
    let return_code: String
    let return_code: String
}
*/
