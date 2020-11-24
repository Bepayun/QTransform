//
//  AffineTransfromView.swift
//  QTransform
//
//  Created by Bepa on 2020/11/19.
//  Copyright © 2020 Bepa. All rights reserved.
//

import UIKit

class AffineTransfromView: UIView {

    var buttonTitleArr: NSMutableArray = NSMutableArray.init()
    var imgView: UIImageView?
    
    open var hostCon: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initViews() {
        
        let size = self.frame.size
        self.buttonTitleArr.addObjects(from: ["平移", "旋转","缩放","旋转平移缩放","验证标准矩阵","平移之后再转换","倒置","矩阵相乘","点矩阵转换","size矩阵转换","rect矩阵转换","复位"])
        for i in 0 ..< buttonTitleArr.count {
            let title: String = buttonTitleArr.object(at: i) as! String
            let button: UIButton = UIButton.init(type: UIButton.ButtonType.system)
            button.setTitle(title, for: UIControl.State.normal)
            button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            button.frame = CGRect.init(x: (size.width / 3.0) * CGFloat(i%3), y: 50.0 * CGFloat(i/3), width: size.width / 3.0, height: 50.0)
            button.addTarget(self, action: #selector(buttonClick(button:)), for: UIControl.Event.touchUpInside)
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 0.5
            self.addSubview(button)
            button.tag = i
        }
        let backView: UIView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 150.0, height: 150.0))
        backView.backgroundColor = UIColor.cyan
        backView.center = self.center
        self.addSubview(backView)
        
        self.imgView = UIImageView.init(frame: backView.bounds)
        self.imgView?.image = UIImage.init(named: "image.jpeg")
        self.imgView?.center = self.center
        self.addSubview(self.imgView!)
    }
    
    @objc func buttonClick(button: UIButton) {
        
        switch button.tag {
        case 0:
            self.translation()
        case 1:
            self.rotation()
        case 2:
            self.scale()
        case 3:
            self.allTransform()
        case 4:
            self.isIdentity()
        case 5:
            self.rotationAfterTranslation()
        case 6:
            self.invert()
        case 7:
            self.matrixMultiplication()
        case 8:
            self.pointTransform()
        case 9:
            self.sizeTransform()
        case 10:
            self.rectTransform()
        case 11:
            self.reset()
        default:
            break;
        }
    }
    
    func showAlert(alertMsg: String) {
        let alertController = UIAlertController(title: nil, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.hostCon?.present(alertController, animated: true, completion: nil)
    }
    
    func reset() {
        UIView.animate(withDuration: 0.3) {
            self.imgView?.transform = CGAffineTransform.identity
        }
    }
    
    func animate(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            self.imgView?.transform = transform
        }
    }
    
    func translation() {
        self.reset()
        let transform: CGAffineTransform = CGAffineTransform(translationX: 50, y: 50)
        self.animate(transform: transform)
    }
    
    func rotation() {
        
        self.reset()
        let transform:CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4.0))
        self.animate(transform: transform)
    }
    
    func scale() {
        
        self.reset()
        let transform:CGAffineTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.animate(transform: transform)
    }
    
    func allTransform() {
        
        self.reset()
        let transform: CGAffineTransform = CGAffineTransform(a: 0.5, b: 0.3, c: 0.5, d: 1.5, tx: 25, ty: 25)
        self.animate(transform: transform)
    }
    
    func isIdentity() {
        
        let isIdentity = self.imgView?.transform.isIdentity
        let alertMsg: String = isIdentity == true ? "是标准矩阵" : "不是标准矩阵"
        self.showAlert(alertMsg: alertMsg)
    }
    
    func rotationAfterTranslation() {
        
        self.reset()
        var translation = CGAffineTransform(translationX: 40, y: 40)
        translation = translation.rotated(by: CGFloat(Double.pi / 4.0))
        self.animate(transform: translation)
    }
    
    func invert() {
        
        self.reset()
        let translation = CGAffineTransform(translationX: 50, y: 50)
        let translationInverted = translation.inverted()
        self.animate(transform: translationInverted)
    }
    
    func matrixMultiplication() {
        self.reset()
        let translation1 = CGAffineTransform(translationX: 40, y: 40)
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translation2 = CGAffineTransform(translationX: -40, y: -40)
        let transform: CGAffineTransform = translation1.concatenating(scale).concatenating(translation2)
        self.animate(transform: transform)
    }
    
    func pointTransform() {
        
        let point = CGPoint.init(x: 100, y: 100)
        let transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 20, ty: 10)
        let transformedPoint = point.applying(transform)
        
        let alertMsg = NSString.init(format: "之前：%@\n之后：%@", point.debugDescription)
        self.showAlert(alertMsg: alertMsg as String)
    }
    
    func sizeTransform() {
        
        let size = CGSize.init(width: 200, height: 200)
        let transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2.0))
        let transformedSize = size.applying(transform)
        
        let alertMsg = NSString.init(format: "之前：%@\n之后：%@", size.debugDescription, transformedSize.debugDescription)
        self.showAlert(alertMsg: alertMsg as String)
    }
    
    func rectTransform() {
        let rect = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        let transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 20, ty: 10)
        let transformedRect = rect.applying(transform)
        
        let alertMsg = NSString.init(format: "之前：%@\n之后：%@", rect.debugDescription, transformedRect.debugDescription)
        self.showAlert(alertMsg: alertMsg as String)
    }
}
