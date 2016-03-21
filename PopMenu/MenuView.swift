//
//  MenuView.swift
//  PopMenu
//
//  Created by randy on 16/3/16.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit
class MenuButton:UIButton
{
    var didTapButtonAtIndex:((index:Int)->())!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: "didTappedButton:", forControlEvents: .TouchUpInside)
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTappedButton(index:Int)
    {
        didTapButtonAtIndex(index: self.tag)
    }
}
class MenuItem:UIView
{
    var icon:UIImageView?
    var button:MenuButton!
    var isVisible:Bool = false
    init(image:UIImage,title:String) {
        super.init(frame:CGRectZero)
        icon = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
        icon?.image = image
        button = MenuButton(type: .Custom)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button.frame = CGRect(x: 5, y: 5, width: self.frame.size.width , height: 30)
        button.setTitle(title, forState: .Normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        //button.backgroundColor = UIColor.greenColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.addSubview(icon!)
        self.addSubview(button)
//        self.backgroundColor = UIColor.grayColor()
    }
    
    override func layoutSubviews() {
        self.button.frame.size.width = (self.superview?.frame.size.width)! - 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuView: UIView {
    
    let itemHeight:CGFloat = 40
    let width:CGFloat = 150
    var items:[MenuItem]?
    var darkBackgroundView:UIView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    init(items:[MenuItem])
    {
        super.init(frame: CGRectZero)
        darkBackgroundView = UIView(frame: UIScreen.mainScreen().bounds)
        darkBackgroundView!.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        darkBackgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismiss"))
        self.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.size.width-8, y: 64)
        self.backgroundColor = UIColor.clearColor()
        self.items = items
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for (index,view) in items!.enumerate()
        {
            view.frame = CGRectMake(0, 10+40*CGFloat(index), self.frame.size.width, itemHeight)
            //view.backgroundColor = UIColor.grayColor()
            //print(view.button.frame)
            self.addSubview(view)
            if index < (items?.count)!-1
            {
                let separatorView = UIView(frame: CGRect(x: 0, y: view.frame.size.height - 1, width: self.frame.size.width, height: 1))
                separatorView.backgroundColor = UIColor.lightGrayColor()
                view.addSubview(separatorView)
            }
            //view.button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
            view.button.tag = index
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(clickAtIndex clickAtIndex:(index:Int)->())
    {
        for view in items!
        {
            view.button.didTapButtonAtIndex = clickAtIndex
        }
        UIApplication.sharedApplication().keyWindow?.addSubview(darkBackgroundView!)
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        self.alpha = 0
        UIView.animateWithDuration(0.1, animations: {() in
            self.frame.size.height = CGFloat(10 + 40 * self.items!.count)
            self.frame.size.width = self.width
            self.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.size.width-8-self.width, y: 64)
            self.alpha = 1
            },completion: {(finished) in
        })
    }
    
    func dismiss()
    {
        UIView.animateWithDuration(0.3, animations: {() in
            self.alpha = 0
            }, completion: {(finished) in
            self.darkBackgroundView?.removeFromSuperview()
            self.removeFromSuperview()
        })
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let contentRect = UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        UIColor.whiteColor().setFill()
        let path = UIBezierPath(roundedRect: contentRect, byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 5, height: 5))
        path.fill()
        let trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: rect.size.width - 25, y: contentRect.origin.y))
        trianglePath.addLineToPoint(CGPoint(x: rect.size.width - 10, y: contentRect.origin.y))
        trianglePath.addLineToPoint(CGPoint(x: rect.size.width - 17, y: rect.origin.y))
        trianglePath.closePath()
        trianglePath.fill()
        //path.addClip()
    }
    

}
