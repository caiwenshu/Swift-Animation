//
//  BallView.swift
//  Swift-DynamicStarbucks
//
//  Created by caiwenshu on 11/4/15.
//  Copyright © 2015 caiwenshu. All rights reserved.
//

import UIKit

class BallView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override var collisionBoundsType:UIDynamicItemCollisionBoundsType {
        return .Path
    }
    
    override var collisionBoundingPath:UIBezierPath {
        
        return generatePentagonPath()
    }

    override func drawRect(rect: CGRect) {
        
        let path = generatePentagramPath(rect)
        
        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        CGContextAddPath(context, path.CGPath)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetLineWidth(context, 1)
        CGContextDrawPath(context, CGPathDrawingMode.Fill)
    }
    
    //五边形
    func generatePentagonPath() ->UIBezierPath {
        
        let path = UIBezierPath()
        
        let centerX:CGFloat = CGFloat(0.0)
        let centerY:CGFloat = 0.0
        
        let radio = self.frame.size.width / 2 - 4.0
        
        let smallRadius = radio * CGFloat(sin(18.0 * M_PI / 180) / cos(36.0 * M_PI / 180))
        
        var lx = [CGFloat](count: 5, repeatedValue: 0)
        var ly = [CGFloat](count: 5, repeatedValue: 0)
        
        var smallx = [CGFloat](count: 5, repeatedValue: 0)
        var smally = [CGFloat](count: 5, repeatedValue: 0)
        
        for index in 0...4 {
            
            let angle:CGFloat = CGFloat((90.0 + Double(index)*72.0) * M_PI / 180.0)
            
            lx[index] = centerX + radio * cos(angle)
            ly[index] = centerY - radio * sin(angle)
            
            let smallAngle:CGFloat = CGFloat((54.0 + Double(index)*72.0 ) * M_PI / 180.0)
            
            smallx[index] = centerX + smallRadius * cos(smallAngle)
            smally[index] = centerY - smallRadius * sin(smallAngle)
        }
        
        
        path.moveToPoint(CGPointMake(lx[0], ly[0]))
        
        for index in 1...4 {
            path.addLineToPoint(CGPointMake(lx[index],ly[index]))
        }
        
        path.addLineToPoint(CGPointMake(lx[0], ly[0]))
        
        return path
    }
    
    //五角星
    func generatePentagramPath(rect: CGRect) ->UIBezierPath {
        
        let path = UIBezierPath()
        
        let centerX = rect.size.width / 2
        let centerY = rect.size.height / 2
        
        let radio = rect.size.width / 2
        
        let smallRadius = radio * CGFloat(sin(18.0 * M_PI / 180) / cos(36.0 * M_PI / 180))
        
        var lx = [CGFloat](count: 5, repeatedValue: 0)
        var ly = [CGFloat](count: 5, repeatedValue: 0)
        
        var smallx = [CGFloat](count: 5, repeatedValue: 0)
        var smally = [CGFloat](count: 5, repeatedValue: 0)
        
        for index in 0...4 {
            
            let angle:CGFloat = CGFloat((90.0 + Double(index) * 72.0) * M_PI / 180.0)
            
            lx[index] = centerX + radio * cos(angle)
            ly[index] = centerY - radio * sin(angle)
            
            let smallAngle:CGFloat = CGFloat((54.0 + Double(index) * 72.0 ) * M_PI / 180.0)
            
            
            smallx[index] = centerX + smallRadius * cos(smallAngle)
            smally[index] = centerY - smallRadius * sin(smallAngle)
        }
        
        path.moveToPoint(CGPointMake(lx[0], ly[0]))
        
        for index in 1...4 {
            
            path.addLineToPoint(CGPointMake(smallx[index],smally[index]))
            path.addLineToPoint(CGPointMake(lx[index],ly[index]))
        }
        
        path.addLineToPoint(CGPointMake(smallx[0], smally[0]))
        path.addLineToPoint(CGPointMake(lx[0], ly[0]))
        
        return path
    }
    
    
}
