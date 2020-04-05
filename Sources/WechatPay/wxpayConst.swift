//
//  File.swift
//  
//
//  Created by xj on 2020/3/31.
//

import Foundation

public struct WxpayConst {
    
    public enum Url {
        case unifiedorder
        case orderquery
        case closeOrder
        case refundOrder
        
        var str: String {
            switch self {
            case .unifiedorder: return "https://api.mch.weixin.qq.com/pay/unifiedorder"
            case .orderquery: return "https://api.mch.weixin.qq.com/pay/orderquery"
            case .closeOrder: return "https://api.mch.weixin.qq.com/pay/closeorder"
            case .refundOrder: return "https://api.mch.weixin.qq.com/secapi/pay/refund"
            }
        }
    }
    
    public enum SignType: String {
        case md5 = "MD5"
        case hmac_sha256 = "HMAC-SHA256"
    }
    
    public enum TradeType: String {
        case app = "APP"
    }
}
