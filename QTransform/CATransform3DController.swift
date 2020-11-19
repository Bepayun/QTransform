//
//  CATransform3DController.swift
//  QTransform
//
//  Created by Bepa on 2020/11/19.
//  Copyright © 2020 Bepa. All rights reserved.
//

import UIKit

class CATransform3DController: UIViewController {

    var animateCube = UIView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transform3D"
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = [UIRectEdge.left, UIRectEdge.right]

        self.testTransForm3D()
    }
    

    func testTransForm3D() {
        let targetRect = CGRect.init(x: 0, y: 0, width: 150, height: 150)
        animateCube.frame = targetRect
        animateCube.center = self.view.center
        self.view.addSubview(animateCube)
        
        // 屛外
        let frontView = UIView.init(frame: targetRect)
        frontView.backgroundColor = UIColor.blue.withAlphaComponent(0.25)
        frontView.layer.transform = CATransform3DTranslate(frontView.layer.transform, 0, 0, 150)
        self.animateCube.addSubview(frontView)

        // 屛内
        let backView = UIView.init(frame: targetRect)
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backView.layer.transform = CATransform3DTranslate(backView.layer.transform, 0, 0, 0.0)
        self.animateCube.addSubview(backView)
        
        // 向左
        let leftView = UIView.init(frame: targetRect)
        leftView.backgroundColor = UIColor.magenta.withAlphaComponent(0.5)
        leftView.layer.transform = CATransform3DTranslate(leftView.layer.transform, -100, 0, 0)
        leftView.layer.transform = CATransform3DRotate(leftView.layer.transform, CGFloat(Double.pi / 2.0), 0, 1, 0)
        self.animateCube.addSubview(leftView)
        
        // 向右
        let rightView = UIView.init(frame: targetRect)
        rightView.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
        rightView.layer.transform = CATransform3DTranslate(rightView.layer.transform, 100, 0, 0)
        rightView.layer.transform = CATransform3DRotate(rightView.layer.transform, CGFloat(Double.pi / 2.0), 0, 1, 0)
        self.animateCube.addSubview(rightView)
        
        // 向下
        let headView = UIView.init(frame: targetRect)
        headView.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        headView.layer.transform = CATransform3DTranslate(headView.layer.transform, 0, 100, 0)
        headView.layer.transform = CATransform3DRotate(headView.layer.transform, CGFloat(Double.pi / 2.0), 1, 0, 0)
        self.animateCube.addSubview(headView)

        // 向上
        let footView = UIView.init(frame: targetRect)
        footView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        footView.layer.transform = CATransform3DTranslate(footView.layer.transform, 0, -100, 0)
        footView.layer.transform = CATransform3DRotate(footView.layer.transform, CGFloat(Double.pi / 2.0), -1, 0, 0)
        self.animateCube.addSubview(footView)
        
        self.animateCube.layer.borderColor = UIColor.red.cgColor
        self.animateCube.layer.borderWidth = 2.0
        
        // self.animateCube.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        var transform3D: CATransform3D = CATransform3DIdentity
        transform3D.m34 = -1.0 / 500.0
        
        self.animateCube.layer.sublayerTransform = transform3D
        
        let angle = CGFloat(Double.pi) / 360.0
        let timer = Timer.init(timeInterval: 1.0 / 60.0, repeats: true) { (_) in
            transform3D = CATransform3DRotate(transform3D, angle, 1, 1, 0.5)
            self.animateCube.layer.sublayerTransform = transform3D
        }
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        
    }
}
