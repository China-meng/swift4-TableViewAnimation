//
//  LrcLabel.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/8/12.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class LrcLabel: UILabel {
    
    var progress: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let drawRect = CGRect(x: 0, y: 0, width: rect.width * CGFloat(progress), height: rect.height)
        UIColor.red.set()
        
        UIRectFillUsingBlendMode(drawRect, .sourceIn)
    }
}
