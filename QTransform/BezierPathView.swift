//
//  BezierPathView.swift
//  QTransform
//
//  Created by Bepa on 2020/11/19.
//  Copyright © 2020 Bepa. All rights reserved.
//

import UIKit

class BezierPathView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.drawLine()
        self.drawCommonCurve()
        self.drawSmoothPath()
    }
    func drawLine() {
        let offset:CGFloat = 50.0
        
        // 绘制矩形
        let rectpath = UIBezierPath(roundedRect: CGRect.init(x: 15, y: offset, width: 300, height: 60), cornerRadius: 5.0)
        
        rectpath.lineWidth = 5.0
        UIColor.lightGray.setStroke()
        rectpath.stroke()
        UIColor.magenta.setFill()
        rectpath.fill()
        
        // 绘制直线
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 25.0, y: offset + 130.0))
        path.addLine(to: CGPoint(x: 300.0, y: offset + 130.0))
        path.lineWidth = 5.0
        UIColor.cyan.setStroke()
        path.stroke()
    }

    func drawCommonCurve() {
        let offset:CGFloat = 260.0
        
        let curvePath = UIBezierPath()
        curvePath.move(to: CGPoint(x: 30.0, y: offset))
        curvePath.addQuadCurve(to: CGPoint(x: 350.0, y: offset), controlPoint: CGPoint(x: 10.0, y: offset - 100))
        UIColor.green.setStroke()
        curvePath.stroke()
    }
    
    func drawSmoothPath() {
        
        let offset:CGFloat = 430
        
        let pointCount:Int = 4
        let pointArr:NSMutableArray = NSMutableArray.init()
        for i in 0...pointCount {
            let px: CGFloat = 15 + CGFloat(i) * CGFloat(80)
            let py: CGFloat = i % 2 == 0 ? offset - 60 : offset + 60
            let point: CGPoint = CGPoint.init(x: px, y: py)
            pointArr.add(point)
        }
        
        let bezierPath = UIBezierPath()
        bezierPath.lineWidth = 2.0
        var prevPoint: CGPoint!
        
        for i in 0 ..< pointArr.count {
            let currPoint:CGPoint = pointArr.object(at: i) as! CGPoint
            
            // 绘制圆圈
            let arcPath = UIBezierPath()
            arcPath.addArc(withCenter: currPoint, radius: 3, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
            UIColor.cyan.setStroke()
            arcPath.stroke()
            
            // 绘制平滑曲线
            if i==0 {
                bezierPath.move(to: currPoint)
            }
            else {
                let conPoint1: CGPoint = CGPoint.init(x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: prevPoint.y)
                let conPoint2: CGPoint = CGPoint.init(x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: currPoint.y)
                bezierPath.addCurve(to: currPoint, controlPoint1: conPoint1, controlPoint2: conPoint2)
            }
            prevPoint = currPoint
        }
        UIColor.red.setStroke()
        bezierPath.stroke()
    }
}
