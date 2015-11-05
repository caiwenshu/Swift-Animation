//
//  CupView.swift
//  Swift-DynamicStarbucks
//
//  Created by caiwenshu on 11/5/15.
//  Copyright © 2015 caiwenshu. All rights reserved.
//

import UIKit
import CoreMotion

class CupView: UIView,UIAccelerometerDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var theAnimator:UIDynamicAnimator?
    
    var speedX:UIAccelerationValue = 0
    var speedY:UIAccelerationValue = 0
    var motionManager:CMMotionManager = CMMotionManager()
    var gravityBehavior:UIGravityBehavior = UIGravityBehavior()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        gravityBehavior.magnitude = 0.5
        
        createBalls()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func createBalls()
    {
        let ballView:BallView = BallView(frame: CGRectMake(0, 0, 40, 40))
        ballView.center = self.center
        
        self.addSubview(ballView)
        
        let ballView1:BallView = BallView(frame: CGRectMake(0, 0, 40, 40))
        ballView1.center = self.center
        
        self.addSubview(ballView1)
        
        
        let ballView2:BallView = BallView(frame: CGRectMake(0, 0, 40, 40))
        ballView2.center = self.center
        
        self.addSubview(ballView2)
        
        
        let ballView3:BallView = BallView(frame: CGRectMake(0, 0, 40, 40))
        ballView3.center = self.center
        
        self.addSubview(ballView3)
        
        let ballView4:BallView = BallView(frame: CGRectMake(0, 0, 40, 40))
        ballView4.center = self.center
        
        self.addSubview(ballView4)
        
        
        motionManager.accelerometerUpdateInterval = 1/5
        
        if(motionManager.accelerometerAvailable) {
            
            let queue = NSOperationQueue.currentQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue!, withHandler: { (data:CMAccelerometerData?, error:NSError?) -> Void in
                self.speedX = (data?.acceleration.x)! / 2
                self.speedY = -(data?.acceleration.y)! / 2
//                print("x:%d,y%d",data?.acceleration.x,data?.acceleration.y)
                
                self.gravityBehavior.gravityDirection = CGVectorMake(CGFloat(self.speedX), CGFloat(self.speedY))
            })
        }
        
        
        addAnimationBehaviour([ballView,ballView1,ballView2,ballView3,ballView4])
    }

    
    func addAnimationBehaviour(ball:[BallView]) {
        
        self.theAnimator = UIDynamicAnimator(referenceView: self)
        
        for b in ball {
            gravityBehavior.addItem(b)
        }
        self.theAnimator! .addBehavior(gravityBehavior)
        
        let coll:UICollisionBehavior = UICollisionBehavior(items: ball)
        
        let path = generatePentagonPath()
        coll.addBoundaryWithIdentifier("pentagon", forPath: path)
        
        self.theAnimator! .addBehavior(coll)
        
        let itemBehavoir:UIDynamicItemBehavior = UIDynamicItemBehavior(items: ball)
        itemBehavoir.elasticity = 0.6
        self.theAnimator!.addBehavior(itemBehavoir)
        
    }

    override func drawRect(rect: CGRect) {
        
       
        let path = generatePentagonPath()
        
        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        CGContextAddPath(context, path.CGPath)
        CGContextSetStrokeColorWithColor(context, UIColor.brownColor().CGColor)
        CGContextSetLineWidth(context, 1)
        let dash:[CGFloat] = [5.0, 5.0]
        CGContextSetLineDash(context, 0, dash, 2) //1
        CGContextStrokePath(context)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
    }
    
    
    //五边形
    func generatePentagonPath() ->UIBezierPath {
        
        let path = UIBezierPath()
        
        let centerX = self.frame.size.width / 2
        let centerY = self.frame.size.height / 2
        
        let radio = self.frame.size.width / 2
        
        let smallRadio = radio * CGFloat(sin(18.0 * M_PI / 180) / cos(36.0 * M_PI / 180))
        
        var lx = [CGFloat](count: 5, repeatedValue: 0)
        var ly = [CGFloat](count: 5, repeatedValue: 0)
        
        var smallx = [CGFloat](count: 5, repeatedValue: 0)
        var smally = [CGFloat](count: 5, repeatedValue: 0)
        
        for index in 0...4 {
            
            let angle:CGFloat = CGFloat(Double(90.0 + Double(index)*72.0) * M_PI / 180.0)
            
            lx[index] = centerX + radio * cos(angle)
            ly[index] = centerY - radio * sin(angle)
            
            let smallAngle:CGFloat = CGFloat(Double(54.0 + Double(index)*72.0 ) * M_PI / 180.0)
            
            
            smallx[index] = centerX + smallRadio*cos(smallAngle)
            smally[index] = centerY - smallRadio * sin(smallAngle)
        }
        
        
        path.moveToPoint(CGPointMake(lx[0], ly[0]))
        
        for index in 1...4 {
            
            path.addLineToPoint(CGPointMake(lx[index],ly[index]))
        }
        
        path.addLineToPoint(CGPointMake(lx[0], ly[0]))
        
        return path
    }
    
    
}
