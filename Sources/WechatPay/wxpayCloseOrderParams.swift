//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

public typealias WxpayCloseOrderParams = WxPayParam

public struct WxpayCloseOrderResp: Content {
    let return_code: String
    let return_msg: String?
    
    let appid: String
    let mch_id: String
    let nonce_str: String
    let sign: String
    let result_code: String
    let result_msg: String
    let err_code: String?
    let err_code_des: String?
}
