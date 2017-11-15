//
//  BaseTransitions.swift
//  工作总结
//
//  Created by mengxuanlong on 17/9/20.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

public enum TransitionType : Int {
    case none
    case dismiss
    case present
    
}

public enum DirectionType : Int {
    case none
    case top
    case left
    case bottom
    case right
    
}
class BaseTransitions: NSObject {
    var _startingAlpha  : CGFloat = 0.0
    var _transitionDuration       = TimeInterval()
    var _transitionType           = TransitionType.none
    var _directionType            = DirectionType.none
    
    
    func initWithTransitionsOfAxis(transitionDuration : TimeInterval, transitionType : TransitionType, directionType : DirectionType)  {
        
        _transitionDuration = transitionDuration
        _transitionType     = transitionType
        _directionType      = directionType
    }

}

extension BaseTransitions : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return _transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView        = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view
        let fromView      = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view
        
        switch _transitionType {
            
        case TransitionType.none:
            break
            
        case TransitionType.present:
            self.makePresentAnimate(toView!, containerView: containerView, transitionContext: transitionContext)
            break
        case TransitionType.dismiss:
            self.makeDismissAnimate(fromView!, containerView: containerView, transitionContext: transitionContext)
            break
            
            
        }
        
    }
    
    
    fileprivate func makePresentAnimate(_ toView : UIView, containerView : UIView, transitionContext : UIViewControllerContextTransitioning) {
        toView.frame = self.setupFromFrame(toView.frame)
        containerView.addSubview(toView)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            toView.frame = self.updateZeroFrame(toView.frame)
            
        }, completion: { (Bool) in
            transitionContext.completeTransition(true)
        })
        
    }
    
    fileprivate func makeDismissAnimate(_ fromView : UIView, containerView : UIView, transitionContext : UIViewControllerContextTransitioning) {
        containerView.addSubview(fromView)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromView.frame = self.setupFromFrame(fromView.frame)
            
        }, completion: { (Bool) in
            transitionContext.completeTransition(true)
        })
        
    }
    
    fileprivate func setupFromFrame(_ toViewFrame : CGRect) -> CGRect {
        var resultValue = toViewFrame
        
        switch _directionType {
        case DirectionType.top:
            resultValue.origin.y = -resultValue.size.height
            break
        case DirectionType.left:
            resultValue.origin.x = -resultValue.size.width
            break
        case DirectionType.bottom:
            resultValue.origin.y = resultValue.size.height
            break
        case DirectionType.right:
            resultValue.origin.x = resultValue.size.width
            break
        default:
            break
        }
        
        
        return resultValue
    }
    
    fileprivate func updateZeroFrame(_ toViewFrame : CGRect) -> CGRect {
        var resultValue = toViewFrame
        resultValue.origin.x = 0
        resultValue.origin.y = 0
        return resultValue
    }
    
}
