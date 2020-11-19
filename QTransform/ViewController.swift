//
//  ViewController.swift
//  QTransform
//
//  Created by Bepa on 2020/11/19.
//  Copyright © 2020 Bepa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var  button: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "QTransform"
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = [UIRectEdge.left, UIRectEdge.right]
        
        self.creatViews()
        
    }

    func creatViews() {
        
        let space: CGFloat = 15.0
        let size: CGSize = self.view.frame.size
    
        let titleArray:NSArray = ["AffineTransfrom", "CATransform3D", "BezierPath"]
        
        var offset: CGFloat = 50.0
        let height: CGFloat = 50.0
        
        for i in 0 ..< titleArray.count {
            let button = UIButton.init(type: UIButton.ButtonType.system)
            button.frame = CGRect.init(x: space, y: offset, width: size.width - space * 2.0, height: height)
            button.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControl.Event.touchUpInside)
            button.setTitle(titleArray.object(at: i) as? String , for: UIControl.State.normal)
            button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            self.view.addSubview(button)
            
            button.tag = i;
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.masksToBounds = true
            button.layer.borderWidth = 1.0
            button.layer.cornerRadius = 5
            
            offset = offset + CGFloat(50) + space
        }
    }
    
    @objc func buttonClicked(button: UIButton) {
        if button.tag == 0 {
            let testTransform :AffineTransfromController = .init()
            self.navigationController?.pushViewController(testTransform, animated: true)
        }
        else if button.tag == 1 {
            let transform3D = CATransform3DController.init()
            self.navigationController?.pushViewController(transform3D, animated: true)
            
        }
        
        else if button.tag == 2 {
            let bezierController = BezierPathController.init()
            
            self.navigationController?.pushViewController(bezierController, animated: true)
        }
    }

}

