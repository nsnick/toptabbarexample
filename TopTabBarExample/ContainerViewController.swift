//
//  ContainerViewController.swift
//  TopTabBarExample
//
//  Created by Nick Wilkerson on 5/1/17.
//  Copyright © 2017 Nick Wilkerson. All rights reserved.
//

import UIKit

enum ActiveViewController {
    case left
    case right
}

class ContainerViewController: UIViewController {

    var buttonView: UIView?
    var leftViewController: LeftViewController?
    var rightViewController: RightViewController?
    var activeViewController: ActiveViewController
    var underlineView: UIView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        activeViewController = .left
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        leftViewController = LeftViewController()
        rightViewController = RightViewController()
        
        if let rightViewController = rightViewController {
            view.addSubview(rightViewController.view)
            addChildViewController(rightViewController)
        }
        
        if let leftViewController = leftViewController {
            view.addSubview(leftViewController.view)
            addChildViewController(leftViewController)
        }
        
        buttonView = UIView()
        view.addSubview(buttonView!)
        buttonView?.translatesAutoresizingMaskIntoConstraints = false
        buttonView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        buttonView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        buttonView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        buttonView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonView?.backgroundColor = UIColor.blue
        
        let leftButton = UIButton()
        buttonView!.addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.topAnchor.constraint(equalTo: buttonView!.topAnchor).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: buttonView!.bottomAnchor).isActive = true
        leftButton.leftAnchor.constraint(equalTo: buttonView!.leftAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalTo: buttonView!.widthAnchor, multiplier: 0.5).isActive = true
        leftButton.setTitle("Green", for: .normal)
        leftButton.addTarget(self, action: #selector(showLeftViewController(sender:)), for: .touchUpInside)
        
        let rightButton = UIButton()
        buttonView!.addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.topAnchor.constraint(equalTo: buttonView!.topAnchor).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: buttonView!.bottomAnchor).isActive = true
        rightButton.rightAnchor.constraint(equalTo: buttonView!.rightAnchor).isActive = true
        rightButton.widthAnchor.constraint(equalTo: buttonView!.widthAnchor, multiplier: 0.5).isActive = true
        rightButton.setTitle("Red", for: .normal)
        rightButton.addTarget(self, action: #selector(showRightViewController(sender:)), for: .touchUpInside)
        
        underlineView = UIView()
        buttonView!.addSubview(underlineView!)
        underlineView?.translatesAutoresizingMaskIntoConstraints = false
        underlineView?.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        underlineView?.widthAnchor.constraint(equalTo:buttonView!.widthAnchor, multiplier:0.25).isActive = true
        underlineView?.centerYAnchor.constraint(equalTo:buttonView!.centerYAnchor, constant:15).isActive = true
        underlineView?.centerXAnchor.constraint(equalTo: leftButton.centerXAnchor).isActive = true
        underlineView?.backgroundColor = UIColor.white

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    func showLeftViewController(sender: AnyObject) {
        if activeViewController != .left {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:0.95, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
                if let leftViewController = self.leftViewController, let rightViewController = self.rightViewController {
                    leftViewController.view.frame.origin.x = 0
                    rightViewController.view.frame.origin.x = self.view.frame.size.width
                    if let underlineView = self.underlineView, let buttonView = self.buttonView {
                        underlineView.frame.origin.x = underlineView.frame.origin.x - buttonView.frame.size.width/2
                    }
                }
            })
            activeViewController = .left
        }
    }
    
    func showRightViewController(sender: AnyObject) {
        NSLog("showRightViewController")
        if activeViewController != .right {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
                if let leftViewController = self.leftViewController, let rightViewController = self.rightViewController {
                    leftViewController.view.frame.origin.x = -self.view.frame.size.width
                    rightViewController.view.frame.origin.x = 0
                    if let underlineView = self.underlineView, let buttonView = self.buttonView {
                        underlineView.frame.origin.x = underlineView.frame.origin.x + buttonView.frame.size.width/2
                    }
                }
            })
            activeViewController = .right
        }
    }

}
