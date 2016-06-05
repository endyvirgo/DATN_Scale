//
//  ViewController.swift
//  DATN_Scale
//
//  Created by KhanhNguyen on 4/13/16.
//  Copyright © 2016 KhanhNguyen. All rights reserved.
//

import UIKit
class ViewController: UIViewController
{
    let label = UILabel()
    var circles = [UITouch: CirclesLabel]()
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        view.multipleTouchEnabled = true
        label.text = "Put on here"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.purpleColor()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(28))
        view.backgroundColor = UIColor.yellowColor()
        view.addSubview(label)
     }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if #available(iOS 9.0, *){
            if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
        for touch in touches
        {
            label.hidden = true
            let circle = CirclesLabel()
            circle.drawAtPoint(touch.locationInView(view),
                               force: touch.force / touch.maximumPossibleForce)
            circles[touch] = circle
            view.layer.addSublayer(circle)
                }}}
    }
     override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if #available(iOS 9.0, *){
            if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
        for touch in touches where circles[touch] != nil
        {
            let circle = circles[touch]!
            circle.drawAtPoint(touch.locationInView(view),
                               force: touch.force / touch.maximumPossibleForce)
                }
            }
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if #available(iOS 9.0, *){
            if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
        for touch in touches where circles[touch] != nil
        {
            let circle = circles[touch]!
            circles.removeValueForKey(touch)
            circle.removeFromSuperlayer()
                }
            }
        }
    }
//    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)
//    {
//        guard let touches = touches else
//        {
//            return
//        }
//        for touch in touches where circles[touch] != nil
//        {
//            let circle = circles[touch]!
//            
//            circle.removeFromSuperlayer()
//        }
//    }
        override func viewDidLayoutSubviews()
        {
            label.frame = view.bounds
        }
}
class CirclesLabel: CAShapeLayer
{
    let text = CATextLayer()
    override init()
    {
        super.init()
        text.foregroundColor = UIColor.purpleColor().CGColor
        text.alignmentMode = kCAAlignmentCenter
        addSublayer(text)
        strokeColor = UIColor.purpleColor().CGColor
        lineWidth = 5
        //fillColor = nil
        fillColor = UIColor.whiteColor().CGColor
        //nil: bien chua co gia tri, chua duoc khoi tao, chua duoc gan gia
        //vong tron se khong duoc do mau khi de gia tri nil
    }
    override init(layer: AnyObject)
    {
        super.init(layer: layer)
    }
    required init?(coder Decoder: NSCoder)
    {
        fatalError("init(coder:) Khong duoc thuc hien")
    }
    func drawAtPoint(location: CGPoint, force: CGFloat)
    {
        let bankinh = 100 + (force * 1)
        path = UIBezierPath(
            ovalInRect: CGRect(
                origin: location.offset(dx: bankinh, dy: bankinh),
                size: CGSize(width: bankinh * 2, height: bankinh * 2))).CGPath
        let gram = force * 350
        let roundGram = Int(gram)
        let string1 = String("\(roundGram) grams")
        text.string = String(string1)
        text.frame = CGRect(origin: location.offset(dx: 75, dy: -bankinh),
                            size: CGSize(width: 300, height: 50))
    }
}
//them thuoc tinh moi offset vao CGPoint
extension CGPoint
{
    func offset(dx dx: CGFloat, dy: CGFloat) -> CGPoint
    {
        return CGPoint(x: self.x - dx, y: self.y - dy)
    }
}
