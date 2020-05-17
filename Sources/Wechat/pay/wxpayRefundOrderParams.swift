//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

public class WxPayRefundOrderParams: WxParams {
    public init(transactionId: String? = nil, outTradeNo: String? = nil, outRefundNo: String, totalFee: Int, refundFee: Int, refundFeeType: String? = nil, refundDesc: String? = nil, refundAccount: String? = nil, notifyUrl: String? = nil) {
        self.transaction_id = transactionId
        self.out_trade_no = outTradeNo
        self.out_refund_no = outRefundNo
        self.total_fee = totalFee
        self.refund_fee = refundFee
        self.refund_fee_type = refundFeeType
        self.refund_desc = refundDesc
        self.refund_account = refundAccount
        self.notify_url = notifyUrl
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

public struct WxPayRefundOrderResp: Content {
    
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
