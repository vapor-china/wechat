//
//  File.swift
//  
//
//  Created by xj on 2020/3/31.
//

import Foundation

public struct WxPayConst {
    
    public enum Url {
        case unifiedOrder
        case orderQuery
        case closeOrder
        case refundOrder
        case oauth2Access
        case refreshATk
        case checkATK
        case userInfo
        
        var str: String {
            switch self {
            case .unifiedOrder: return "https://api.mch.weixin.qq.com/pay/unifiedorder"
            case .orderQuery: return "https://api.mch.weixin.qq.com/pay/orderquery"
            case .closeOrder: return "https://api.mch.weixin.qq.com/pay/closeorder"
            case .refundOrder: return "https://api.mch.weixin.qq.com/secapi/pay/refund"
            case .oauth2Access: return "https://api.weixin.qq.com/sns/oauth2/access_token"
            case .refreshATk: return "https://api.weixin.qq.com/sns/oauth2/refresh_token"
            case .checkATK: return "https://api.weixin.qq.com/sns/auth"
            case .userInfo: return "https://api.weixin.qq.com/sns/userinfo"
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
