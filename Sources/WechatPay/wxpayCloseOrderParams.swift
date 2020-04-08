//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

public typealias WxpayCloseOrderParams = WxPayParam

public struct WxpayCloseOrderResp: Content {
    public let return_code: String
    public let return_msg: String?
    
    public let appid: String
    public let mch_id: String
    public let nonce_str: String
    public let sign: String
    public let result_code: String
    public let result_msg: String
    public let err_code: String?
    public let err_code_des: String?
}
