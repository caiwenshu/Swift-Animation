//
//  ViewController.swift
//  Swift-TwitterSplashAnimation
//
//  Created by caiwenshu on 11/3/15.
//  Copyright © 2015 caiwenshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        let maskLayer:CALayer = CALayer()
        maskLayer.contents = UIImage(named: "logo")?.CGImage
        maskLayer.frame = CGRectMake(0, 0, 60, 60)
        maskLayer.position = self.view.center
        self.view.layer.mask  = maskLayer
        
        // 接下来就是让 mask 做动画
        let transformAnimations = CAKeyframeAnimation(keyPath: "bounds")
        transformAnimations.delegate = self
        transformAnimations.duration = 1
        transformAnimations.beginTime = CACurrentMediaTime() + 1
        
        
        let initalBounds:NSValue = NSValue(CGRect: maskLayer.bounds)
        let secondBounds:NSValue = NSValue(CGRect:CGRectMake(0, 0, 50, 50))
        let finalBounds:NSValue = NSValue(CGRect:CGRectMake(0, 0, 2000, 2000))
        
        transformAnimations.values = [initalBounds, secondBounds, finalBounds]
        transformAnimations.keyTimes = [0, 0.5, 1]
        transformAnimations.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        
        transformAnimations.removedOnCompletion = false
        transformAnimations.fillMode = kCAFillModeForwards
        
        self.view.layer.mask?.addAnimation(transformAnimations, forKey: "maskAnimation")
        
        
        UIView.animateWithDuration(0.25, delay: 1.3, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            
            self.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
            
            }) { (complete) -> Void in
                
                UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.view.transform = CGAffineTransformIdentity
                    
                    }, completion:nil
                )
                
        }
        
        let maskBgView = UIView(frame: self.view.layer.frame)
        maskBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(maskBgView)
        self.view.bringSubviewToFront(maskBgView)
        
        
        UIView.animateWithDuration(0.1, delay: 1.35, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            maskBgView.alpha = 0.0
            }) { (complete) -> Void in
                maskBgView.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

