//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor
import Coda

public class WxPayOrderQueryPramas: WxParams {
    public init(transactionId: String? = nil, outTradeNo: String? = nil) {
        self.transaction_id = transactionId
        self.out_trade_no = outTradeNo
    }
    @Coda(name: "transaction_id", defaultValue: nil)
    var transaction_id: String?
    @Coda(name: "out_trade_no", defaultValue: nil)
    var out_trade_no: String?
}


public typealias WxPayOrderQueryResp = WxPayCallbackResp

