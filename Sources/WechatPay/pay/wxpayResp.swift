//
//  File.swift
//  
//
//  Created by xj on 2020/4/2.
//

import Vapor

struct WxPayUnifiedOrderResponse: Content {
    
        let return_code: String
        let return_msg: String
        let appid: String
        let mch_id: String
        let nonce_str: String
        let sign: String
        let result_code: String
        let prepay_id: String
        let trade_type: String
      
}

extension WxPayUnifiedOrderResponse {
    
    var isSuccess: Bool {
        return result_code == "SUCCESS"
    }
}
