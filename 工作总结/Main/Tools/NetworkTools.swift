//
//  NetworkTools.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/6/29.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
import Alamofire

enum HttpMethodType {
    case get
    case post
}

class NetworkTools: NSObject {
    // 类方法 前面加class
    class func requestHttpData(type:HttpMethodType,URLString:String,parameters
        :[String:Any]? = nil,finishedCallBack:@escaping (_ resultJsonData:Any)->()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString,method:method,parameters:parameters).responseJSON { (response) in
            printLog("URL == "+" --- \(String(describing: response.request))")
//            print("服务器根据URL的响应: \(response.response)")
//            print("服务器返回的data: \(response.data)")

//            print("Error: \(response.error)")
            
            guard let result = response.result.value else {
                print(response.result.error ?? "")
                return
            }
            // 将结果回调出去
            finishedCallBack(result)
            
        }
    }


}
