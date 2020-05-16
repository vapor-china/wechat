//
//  File.swift
//  
//
//  Created by xj on 2020/4/2.
//

import Foundation
import Crypto


public struct WxPaySign {
    
    public static func sign(dic: [String: String], key: String, signType: WxPayConst.SignType) throws -> String {

        let signStr = generateSignStr(dic: dic)
        
        let signTemp = signStr + "&key=\(key)"
        
        var sign = ""
        if signType == .md5 {
            sign = encodeWithMD5(content: signTemp)
        } else {
            if let data = encodeWithHMAC(content: signTemp, key: key, type: SHA256.self) {
                sign = String(data: data, encoding: .utf8)?.uppercased() ?? ""
            }
            
        }
        
        guard !sign.isEmpty else {
            throw WxPayError(reason: "sign failure")
        }
        
        return sign
    }
    
     
}

extension WxPaySign {
    static func encodeWithMD5(content: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(content.utf8))
        let str = digest.map { String(format: "%02hhx", $0) }.joined().uppercased()
        return str
    }
    
     static func encodeWithHMAC<H: HashFunction>(content: String, key: String, type: H.Type) -> Data? {
        let keyData = key.data(using: .utf8)!
            
        let skey = SymmetricKey(data: keyData)
        var hmac = HMAC<H>(key: skey)
        
        let contentData = content.data(using: .utf8)!
        hmac.update(data: contentData)
        
        let result = hmac.finalize()
        
        let resultStr = result.map { String(format: "%02hhx", $0) }.joined()
        guard let data = resultStr.data(using: .utf8) else { return nil }
        
        return data
    }

     static func generateSignStr(dic: [String: String]) -> String {
        let newDic = dic.filter { (key, value) -> Bool in
            if key == "sign" || value.isEmpty {
                return false
            } else { return true }
        }
        let dic2 = newDic.sorted { (k1, k2) -> Bool in
            return k1.key < k2.key
        }
        var queryString = ""
        
        for (k,v) in dic2 {
            queryString = queryString + "&" + k + "=" + v
        }
        
        let signQuery = String(queryString.dropFirst(1))
        return signQuery
    }
}
