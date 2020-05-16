//
//  File.swift
//  
//
//  Created by xj on 2020/4/3.
//

import Vapor

extension WxPayClient {
    
    public func dealwithCallback(req: Request) throws -> WxPayCallbackResp {
        let resp = try req.content.decode(WxPayCallbackResp.self, using: XMLDecoder())
        
        
        // verfy sign
        if !resp.isTransactionSuccess {
            throw WxPayError(reason: "wx pay call back failed")
        }
        
        if resp.sign.isEmpty {
            throw WxPayError(reason: "verfy sign is empty")
        }
        
        let signDic = MirrorExt.generateDic(model: resp)
        let result = try WxPaySign.sign(dic: signDic, key: mchSecret, signType: signType)
        if resp.sign != result {
            throw WxPayError(reason: "verfy sign failed")
        }
        
        return resp
    }
}

public struct WxPayCallbackReturn {
    
    public static let OK = """
                <xml>
                  <return_code><![CDATA[SUCCESS]]></return_code>
                  <return_msg><![CDATA[OK]]></return_msg>
                </xml>
            """
    public static func NotOK(errMsg: String) -> String {
        let fail = """
                       <xml>
                         <return_code><![CDATA[FAIL]]></return_code>
                         <return_msg><![CDATA[\(errMsg)]]></return_msg>
                       </xml>
                   """
        return fail
    }
}



