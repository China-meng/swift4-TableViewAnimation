//
//  LrcLineModel.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/8/12.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class LrcLineModel: NSObject {
    var lrcTime: TimeInterval = 0
    var lrcText: String = ""
    
    init(lrclineString: String) {
        super.init()
        
        lrcText = lrclineString.components(separatedBy: "]")[1]
        
        // [00:15.58]追究什么对错　你的谎言　基于你还爱我
        let range = (lrclineString.characters.index(lrclineString.startIndex, offsetBy: 1) ..< lrclineString.characters.index(lrclineString.startIndex, offsetBy: 9))
        lrcTime = timeWithTimeStr(lrclineString.substring(with: range))
    }
    
    fileprivate func timeWithTimeStr(_ timeString: String) -> TimeInterval {
        // 03:21.82
        let min = Double((timeString as NSString).substring(to: 2))!
        let second = Double((timeString as NSString).substring(with: NSRange(location: 3, length: 2)))!
        let haomiao = Double((timeString as NSString).substring(from: 6))!
        return (min * 60 + second + haomiao * 0.01)
    }


}
