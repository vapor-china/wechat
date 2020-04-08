<img src="images/banner.png"/>

[![Build Status](https://img.shields.io/badge/platforms-macOS%20%7C%20Ubuntu-green.svg)](https://github.com/vapor-china/wechat-pay)
[![Swift](https://img.shields.io/badge/Swift-5.2-orange.svg)](https://swift.org)
[![Swift](https://img.shields.io/badge/Vapor-4-orange.svg)](https://vapor.codes)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)
[![Xcode](https://img.shields.io/badge/macOS-15.0-blue.svg)](https://developer.apple.com/macOS)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)



`WechatPay` 是一个基于vapor4的微信支付SDK。支持 macOS, Ubuntu。

[English 📔](README.md)

## 安装

### Swift Package Manager

要使用苹果的 Swift Package Manager 集成，将以下内容作为依赖添加到你的 `Package.swift`：

```swift
.package(url: "https://github.com/vapor-china/wechat-pay.git", from: "1.0.0")
```

这里是一个 `PackageDescription` 实例：

```swift
// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor-china/wechat-pay.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "WechatPay", package: "wechat-pay")
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
```

## 使用

### 初始化client
```swift
        let client = WxpayClient(appId: "your appid", mchId: "you mchId", apiKey: "your mch apiKey")
        
```

### 支付预下单
```swift
        let param = WxPayUnifiedOrderPramas(out_trade_no: "macos\(Int(Date().timeIntervalSince1970))", body: "vapor test", total_fee: 1, spbill_create_ip: "127.0.0.1", notify_url: "http://notify.objcoding.com/notify", trade_type: .app)
         
        return try client.unifiedOrder(param, req: req)
```

### 查询支付结果
```swift 
    let param = WxpayOrderQueryPramas(out_trade_no: "your out trade no")
        try client.orderQuery(param, req: req)
```

### 关闭订单
```swift
    let param = WxpayCloseOrderParams(out_trade_no: "your out trade no")
        client.closeOrder(param, req: req)
```

### 退款
```swift 
    let param = WxpayRefundOrderParams(out_trade_no: "out trade no", out_refund_no: " out refund no", total_fee: 1, refund_fee: 1, refund_fee_type: "", refund_desc: "", refund_account: "", notify_url: "notify url")
        client.refundOrder(param, req: req)
```

### 支付回调解析处理
router请写post请求
```swift 
    try client.dealwithCallback(req: req)

    if 成功 {
      return WxpayCallbackReturn.OK.encodeResponse(for: req)
    } else {
      return WxpayCallbackReturn.NotOK(errMsg: "msg").encodeResponse(for: req)
    }   
```


## License

AliSMS is released under an MIT license. See [License.md](https://github.com/vapor-china/wechat-pay/blob/master/LICENSE) for more information.
