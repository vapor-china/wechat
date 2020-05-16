//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor
import Coda

public typealias WxPayCloseOrderParams = WxPayParam

public struct WxPayCloseOrderResp: Content {
    
    @Coda(name: "return_code", defaultValue: "")
    public var returnCode: String
    
    @Coda(name: "return_msg", defaultValue: nil)
    public var returnMsg: String?
    @Coda(name: "appid", defaultValue: "")
    public var appId: String
    @Coda(name: "mch_id", defaultValue: "")
    public var mchId: String
    @Coda(name: "nonce_str", defaultValue: "")
    public var nonceStr: String
    @Coda(name: "sign", defaultValue: "")
    public var sign: String
    @Coda(name: "result_code", defaultValue: "")
    public var resultCode: String
    @Coda(name: "result_msg", defaultValue: "")
    public var resultMsg: String
    @Coda(name: "err_code", defaultValue: nil)
    public var errCode: String?
    @Coda(name: "err_code_des", defaultValue: nil)
    public var errMsg: String?
    
    public init(returnCode: String, returnMsg: String?, appId: String, mchId: String, nonceStr: String, sign: String, resultCode: String, resultMsg: String, errCode: String?, errMsg: String?) {
        self.returnCode = returnCode
        self.returnMsg = returnMsg
        self.appId = appId
        self.mchId = mchId
        self.nonceStr = nonceStr
        self.sign = sign
        self.resultCode = resultCode
        self.resultMsg = resultMsg
        self.errCode = errCode
        self.errMsg = errMsg
    }
}

extension WxPayCloseOrderResp: CodableModel {
    public init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}
