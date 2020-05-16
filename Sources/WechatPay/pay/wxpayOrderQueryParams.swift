//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

public class WxPayOrderQueryPramas: WxParams {
    public init(transaction_id: String? = nil, out_trade_no: String? = nil) {
        self.transaction_id = transaction_id
        self.out_trade_no = out_trade_no
    }
    
    var transaction_id: String?
    var out_trade_no: String?
}


public typealias WxPayOrderQueryResp = WxPayCallbackResp

