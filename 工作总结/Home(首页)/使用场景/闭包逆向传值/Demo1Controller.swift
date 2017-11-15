//
//  Demo1Controller.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/22.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

//定义闭包类型
typealias InputStr = (_ str:String) -> Void

class Demo1Controller: UIViewController {
    //声明一个闭包
    var backInputStr: InputStr?
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
extension Demo1Controller {
    fileprivate func setupUI1(){
        self.navigationItem.title = "场景1:闭包逆向传值"
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
        
        button.setTitle("返回", for: .normal)
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

        
        if backInputStr != nil {
            if  let tempString = textField.text {
                backInputStr!(tempString)
            }
        }
        


  
        _ = navigationController?.popViewController(animated: true)
    }
    
}
