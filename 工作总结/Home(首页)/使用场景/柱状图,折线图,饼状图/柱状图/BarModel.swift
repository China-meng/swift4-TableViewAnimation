//
//  BarModel.swift
//  工作总结
//
//  Created by mengxuanlong on 2017/11/14.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class BarModel: NSObject {
    //卡名
    @objc dynamic var cardName : String = ""
    //
    @objc dynamic var right : String = ""
    //金额
    @objc dynamic var totalMoney : String = ""
    
    
    //定义字典转模型的构造函数
    init(dic :[String :String]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
