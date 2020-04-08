//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

public class WxpayRefundOrderParams: WxParams {
    public init(transaction_id: String? = nil, out_trade_no: String? = nil, out_refund_no: String, total_fee: Int, refund_fee: Int, refund_fee_type: String? = nil, refund_desc: String? = nil, refund_account: String? = nil, notify_url: String? = nil) {
        self.transaction_id = transaction_id
        self.out_trade_no = out_trade_no
        self.out_refund_no = out_refund_no
        self.total_fee = total_fee
        self.refund_fee = refund_fee
        self.refund_fee_type = refund_fee_type
        self.refund_desc = refund_desc
        self.refund_account = refund_account
        self.notify_url = notify_url
    }
    
    public let transaction_id: String?
    public let out_trade_no: String?
    public let out_refund_no: String
    public let total_fee: Int
    public let refund_fee: Int
    public let refund_fee_type: String?
    public let refund_desc: String?
    public let refund_account: String?
    public let notify_url: String?
}

public struct WxpayRefundOrderResp: Content {
    
    public let return_code: String
    public let return_msg: String?
    
    public let result_code: String
    public let err_code: String?
    public let err_code_des: String?
    public let appid: String
    public let mch_id: String
    public let nonce_str: String
    public let sign: String
    public let transaction_id: String
    public let out_trade_no: String
    public let out_refund_no: String
    public let refund_id: String
    public let refund_fee: Int
    public let settlement_refund_fee: Int?
    public let total_fee: Int
    public let settlement_total_fee: Int?
    public let fee_type: String?
    public let cash_fee: Int
    public let cash_fee_type: String?
    public let cash_refund_fee: Int?
    public let coupon_refund_fee: Int?
    public let coupon_refund_count: Int?
}
