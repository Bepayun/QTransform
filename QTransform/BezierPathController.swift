
//
//  BezierPathController.swift
//  QTransform
//
//  Created by Bepa on 2020/11/19.
//  Copyright © 2020 Bepa. All rights reserved.
//

import UIKit

class BezierPathController: UIViewController {

    var bezierView:BezierPathView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "BezierPathController"
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = [UIRectEdge.left, UIRectEdge.right]
        
        self.bezierView = BezierPathView.init(frame: self.view.bounds)
        self.view.addSubview(self.bezierView!);
    }
    


}
