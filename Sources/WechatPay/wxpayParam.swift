//
//  File.swift
//  
//
//  Created by xj on 2020/4/1.
//

import Foundation
import Vapor
import CryptoKit


public protocol WxParams: class {}

public class WxPayParam: WxParams {
    public init(out_trade_no: String) {
        self.out_trade_no = out_trade_no
    }
    
    public var out_trade_no: String // 商户系统内部订单号，
}

extension WxParams {

    func nonceStr() -> String? {
        let tims = Date().timeIntervalSince1970
        let uuidStr = UUID().uuidString + "\(tims)"
        if let uuidData = uuidStr.data(using: .utf8) {
            return WxPaySign.encodeWithMD5(content: uuidData.base64EncodedString())
        } else {
            return nil
        }
    }
    
    func base64(str: String) -> String {
        let data = Data(str.utf8)
        return data.base64EncodedString()
    }

}
extension WxPayClient {
    
    func generateParams<T: WxParams>(param: T) throws -> [String: String] {
        
        var dics = MirrorExt.generateDic(model: param)
        
        dics["appid"] = appId
        dics["mch_id"] = mchId
        dics["sign_type"] = signType.rawValue
        guard let nonceStr = param.nonceStr() else {
            return [:]
        }
        dics["nonce_str"] = nonceStr
        
       let sign = try WxPaySign.sign(dic: dics, key: apiKey, signType: signType)
        
        dics["sign"] = sign
        
        return dics
    }
    
}

extension Dictionary where Key == String, Value == String {
    
    var xmlString: String {
                let root = XMLElement(name: "xml")
                let xml = XMLDocument(rootElement: root)
                for (key, value) in self {
                    root.addChild(XMLElement(name: key, stringValue: value))
                }
                return xml.xmlString
    }
}


