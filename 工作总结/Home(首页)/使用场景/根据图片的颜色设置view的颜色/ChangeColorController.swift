//
//  ChangeColorController.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/8/12.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class ChangeColorController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }
    


}
extension  ChangeColorController {
    func setupUI() {
        view.backgroundColor = UIColor.white
        let viewM = UIView()
        viewM.frame = view.frame
        view.addSubview(viewM)
        let iconImage = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        iconImage.image = UIImage(named: "demo")
        viewM.addSubview(iconImage)
        viewM.backgroundColor = iconImage.image?.getPixelColor(pos: CGPoint(x:  iconImage.centerX, y:  iconImage.centerY))


    }

}
