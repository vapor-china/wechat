//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

public class WxpayRefundOrderParams: WxParams {
    public init(transaction_id: String?, out_trade_no: String?, out_refund_no: String, total_fee: Int, refund_fee: Int, refund_fee_type: String?, refund_desc: String?, refund_account: String?, notify_url: String?) {
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
    
    let transaction_id: String?
    let out_trade_no: String?
    let out_refund_no: String
    let total_fee: Int
    let refund_fee: Int
    let refund_fee_type: String?
    let refund_desc: String?
    let refund_account: String?
    let notify_url: String?
}

public struct WxpayRefundOrderResp: Content {
    
    let return_code: String
    let return_msg: String?
    
    let result_code: String
    let err_code: String?
    let err_code_des: String?
    let appid: String
    let mch_id: String
    let nonce_str: String
    let sign: String
    let transaction_id: String
    let out_trade_no: String
    let out_refund_no: String
    let refund_id: String
    let refund_fee: Int
    let settlement_refund_fee: Int?
    let total_fee: Int
    let settlement_total_fee: Int?
    let fee_type: String?
    let cash_fee: Int
    let cash_fee_type: String?
    let cash_refund_fee: Int?
    let coupon_refund_fee: Int?
    let coupon_refund_count: Int?
}
