//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class MyView: UIView {
    override func drawRect(rect: CGRect) {
        
        var path = UIBezierPath()
        
        let centerX = rect.size.width / 2
        let centerY = rect.size.height / 2
        
        let radio = rect.size.width / 2
        
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
            
            cos(smallAngle)
            
            smallx[index] = centerX + smallRadio*cos(smallAngle)
            smally[index] = centerY - smallRadio * sin(smallAngle)
        }
        
        
        path.moveToPoint(CGPointMake(lx[0], ly[0]))
        
        for index in 1...4 {
            
            path.addLineToPoint(CGPointMake(smallx[index],smally[index]))
            path.addLineToPoint(CGPointMake(lx[index],ly[index]))
        }
        
        path.addLineToPoint(CGPointMake(smallx[0], smally[1]))
        

        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        CGContextAddPath(context, path.CGPath)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetLineWidth(context, 1)
        CGContextDrawPath(context, CGPathDrawingMode.Fill)
    }
    
}


var vi:MyView = MyView(frame: CGRectMake(0,0,100,100))
