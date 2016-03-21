//
//  ViewController.swift
//  PopMenu
//
//  Created by randy on 16/3/16.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func show(sender: AnyObject)
    {
        let menuItem = MenuItem(image: UIImage(named: "plus")!, title: "添加新网关")
        let menuItem1 = MenuItem(image: UIImage(named: "warning")!, title: "扫描二维码")
        let menuItem2 = MenuItem(image: UIImage(named: "wrench")!, title: "加好友")
        let menuItem3 = MenuItem(image: UIImage(named: "lock")!, title: "搔一搔")

        let menu = MenuView(items:[menuItem,menuItem1,menuItem2,menuItem3])
        menu.show(clickAtIndex: {(index) in
            menu.dismiss()
            print("tapped:",index)
        })
    }
    
    func menuView(menuView: MenuView, didTappedButtonAtIndex: Int) {
        menuView.dismiss()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

