<img src="images/banner.png"/>

[![Build Status](https://img.shields.io/badge/platforms-macOS%20%7C%20Ubuntu-green.svg)](https://github.com/vapor-china/wechat-pay)
[![Swift](https://img.shields.io/badge/Swift-5.2-orange.svg)](https://swift.org)
[![Swift](https://img.shields.io/badge/Vapor-4-orange.svg)](https://vapor.codes)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)
[![Xcode](https://img.shields.io/badge/macOS-15.0-blue.svg)](https://developer.apple.com/macOS)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)



`Wechat` is a vapor 4 kit of wechat pay service. It support macOS, Ubuntu. You can use the kit to call wechat pay service. 


[中文版🇨🇳](README.md)

## Installation

### Swift Package Manager

To integrate using Apple's Swift package manager, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/vapor-china/wechat.git", from: "2.0.0")
```

Here's an example `PackageDescription`:

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
        .package(url: "https://github.com/vapor-china/wechat.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Wechat", package: "wechat")
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
```

## Usage

### register wechat
```swift
        let mch = WechatConfiguare.MCH(mchId: "you mchId", secret: "your mch secret") // is optional, if your don't need wechat pay, is can set nil
        let wechatConfig = try WechatConfiguare(appId: "your appid", appSecret: "your app secret", mch: mch)
        app.wechat.use(wechatConfig)
```

## User

### get access token 
```swift 
        try req.wechat.fetchUserAccessToken(code)
```

### get user info
```swift
        try req.wechat.getUserInfo(access: atk, openId: openid)
```

### example code get user info
```swift
        try req.wechat.fetchUserAccessToken(code).flatMapThrowing({ (tokenModel) in
            if let errmsg = tokenModel.isErrMsg {
                throw RespError(err: .normal, msg: errmsg)
            }
            guard let atk = tokenModel.accessToken else { throw RespError(err: .normal, msg: "access token is not exists") }
            guard let openid = tokenModel.openId else { throw RespError(err: .normal, msg: "openid is not exists") }
            return try req.wechat.getUserInfo(access: atk, openId: openid).encodeResponse(for: req)
        }).flatMap { $0 }
```

### refresh access token
```swift 
        try req.wechat.refresh(access: token)
```

### valid access token
```swift
        req.wechat.valid(access: token, openId: openId)
```

## Pay

### unified order
```swift
    let param = WxPayUnifiedOrderPramas(outTradeNo: "macos\(Int(Date().timeIntervalSince1970))", body: "vapor test", totalFee: 1, spbillCreateIp: "127.0.0.1", notifyUrl: "http://notify.objcoding.com/notify", tradeType: .app)
         
    return try req.wechat.unified(order: param)
```

### query order result
```swift 
    let param = WxPayOrderQueryPramas(outTradeNo: "your out trade no")
    try req.wechat.query(order: param)
```

### close order
```swift
    let param = WxPayCloseOrderParams(outTradeNo: "your out trade no")
    try req.wechat.close(order: param)
```

### refund order
```swift 
    let param = WxPayRefundOrderParams(outTradeNo: "out trade no", outRefundNo: " out refund no", totalFee: 1, refundFee: 1, refundFeeType: "", refundDesc: "", refundAccount: "", notifyUrl: "http://notify.objcoding.com/notify")
    try req.wechat.refund(order: param)
```

### notify parse
router use post
```swift 

    let res = try req.wechat.payCallback()
    ······
    if res.isTransactionSuccess {
      return WxPayCallbackReturn.OK.encodeResponse(for: req)
    } else {
      return WxPayCallbackReturn.NotOK(errMsg: "msg").encodeResponse(for: req)
    }   
```



## License

Wechat is released under an MIT license. See [License.md](https://github.com/vapor-china/wechat/blob/master/LICENSE) for more information.
