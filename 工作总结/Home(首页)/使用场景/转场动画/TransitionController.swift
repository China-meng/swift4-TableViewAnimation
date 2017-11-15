//
//  TransitionController.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/9/6.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class TransitionController: UIViewController {
    var _directionType = DirectionType.none
    
//    override init(){
//        super.init()
//        self.hidesBottomBarWhenPushed = true
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
    }



    func buttonEvent(_ directionType : DirectionType)  {
        
        _directionType = directionType
        
        let vc = EachController()
        
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        
        self.present(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension TransitionController {
    fileprivate func setUI(){
    view.backgroundColor = UIColor.white
    let btn = UIButton(type: .custom)
    btn.setTitle("动画", for: .normal)
    btn.setTitleColor(UIColor.black, for: .normal)
    btn.backgroundColor = UIColor.groupTableViewBackground
    view.addSubview(btn)
    btn.snp.makeConstraints { (make) in
        make.width.equalTo(300)
        make.height.equalTo(40)
        make.center.equalTo(view)
    }
    
    
    btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        
    }
    func btnTapped(_ sender: Any){
        self.buttonEvent(DirectionType.right)
    }
    

}

extension TransitionController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transitions = BaseTransitions()
        transitions.initWithTransitionsOfAxis(transitionDuration: 0.4, transitionType: TransitionType.present, directionType: _directionType)
        return transitions
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitions = BaseTransitions()
        transitions.initWithTransitionsOfAxis(transitionDuration: 0.4, transitionType: TransitionType.dismiss, directionType: _directionType)
        return transitions
    }
    
    
}
