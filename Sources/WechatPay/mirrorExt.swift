//
//  File.swift
//  
//
//  Created by xj on 2020/4/1.
//

import Foundation

class MirrorExt {

    static func generateDic<T>(model: T) -> Dictionary<String,String> {

            var para : [String : String] = [:]

            var mirror: Mirror? = Mirror(reflecting: model)
            repeat {
                for (fkey,fval) in mirror!.children {
                    if case Optional<Any>.none = fval {
                        continue
                    }
                    var val = ""
                    if  case Optional.some(let value) = fval as? String {
                        val = value
                    } else if  case Optional.some(let value) = fval as? Int {
                        val = "\(value)"
                    } else {
                        // may has omission
                         val = "\(fval)"
                    }
                    
                    if let key = fkey, val != "" {
                       para[key] = val
                    }
                }
                mirror = mirror?.superclassMirror
            } while mirror != nil
            
            return para
        }
}
