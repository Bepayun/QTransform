//
//  AffineTransfromController.swift
//  QTransform
//
//  Created by Bepa on 2020/11/19.
//  Copyright © 2020 Bepa. All rights reserved.
//

import UIKit

class AffineTransfromController: UIViewController {

    var affineView: AffineTransfromView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "AffineTransfrom"
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = [UIRectEdge.left, UIRectEdge.right]
        
        self.affineView = AffineTransfromView.init(frame: self.view.bounds)
        self.affineView?.backgroundColor = UIColor.magenta
        self.affineView?.hostCon = self
        self.view.addSubview(self.affineView!);
    }
}
