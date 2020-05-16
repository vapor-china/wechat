//
//  File.swift
//  
//
//  Created by xj on 2020/4/5.
//

import Vapor

public class WxPayUnifiedOrderPramas: WxPayParam {
    
public init(outTradeNo: String, deviceInfo: String? = nil, body: String, detail: String? = nil, attach: String? = nil, feeType: String? = nil, totalFee: Int, spbillCreateIp: String, timeStart: String? = nil, timeExpire: String? = nil, goodsTag: String? = nil, notifyUrl: String, tradeType: WxPayConst.TradeType, limitPay: String? = nil, receipt: String? = nil) {
        self.device_info = deviceInfo
        self.body = body
        self.detail = detail
        self.attach = attach
        self.fee_type = feeType
        self.total_fee = totalFee
        self.spbill_create_ip = spbillCreateIp
        self.time_start = timeStart
        self.time_expire = timeExpire
        self.goods_tag = goodsTag
        self.notify_url = notifyUrl
        self.trade_type = tradeType.rawValue
        self.limit_pay = limitPay
        self.receipt = receipt
        super.init(outTradeNo: outTradeNo)
    }
    
    public var device_info: String? // 商品描述交易字段
    public var body: String // 商品描述交易字段
    public var detail: String? // 商品详细描述
    public var attach: String? // 附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据
    public var fee_type: String? // 符合ISO 4217标准的三位字母代码，默认人民币：CNY
    public var total_fee: Int // 订单总金额，单位为分
    public var spbill_create_ip: String // 调用微信支付API的机器IP
    public var time_start: String? // 订单生成时间，格式为yyyyMMddHHmmss
    public var time_expire: String? // 订单失效时间，格式为yyyyMMddHHmmss
    public var goods_tag: String?  // 订单优惠标记，代金券或立减优惠功能的参数
    public var notify_url: String // 接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
    public var trade_type: String // 支付类型
    public var limit_pay: String? // no_credit--指定不能使用信用卡支付
    public var receipt: String? // Y，传入Y时，支付成功消息和支付详情页将出现开票入口。需要在微信支付商户平台或微信公众平台开通电子发票功能，传此字段才可生效
    
    
}


public struct WxPayAppReqParams: Content {
    public let appid: String
    public let noncestr: String
    public let partnerid: String
    public let package = "Sign=WXPay"
    public let prepayid: String
    public let timestamp: String
    public var sign: String = ""
}
