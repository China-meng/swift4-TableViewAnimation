//
//  ClosureController.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/21.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
import SnapKit

class ClosureController: UIViewController {
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI1()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ClosureController {
    fileprivate func setupUI1() {
        self.navigationItem.title = "闭包的使用"
        view.backgroundColor = UIColor.white
        

        textField.borderStyle = UITextBorderStyle.roundedRect
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.center.equalTo(self.view)
        }
        textField.placeholder = "反向传值"
        
        let button  = UIButton(type: .custom)

        button.setTitle("跳转", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.centerX.equalTo(textField.snp.centerX)
        }
     

        button.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)


    }
    
    func btnTapped(){
        let demo1 = Demo1Controller()
        demo1.backInputStr = {(str)in
            self.textField.text = str;
            
        }
        self.navigationController?.pushViewController(demo1, animated: true)
    }
}


