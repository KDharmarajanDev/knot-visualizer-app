//
//  SideBar.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/28/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

import UIKit

@objc protocol SideBarDelegate {
    func sideBarDidSelectButtonAtIndex(index:Int)
    @objc optional func sideBarWillClose()
    @objc optional func sideBarWillOpen()
}

class SideBar: NSObject, SideBarTableViewControllerDelegate {
    
    let barWidth : CGFloat = 150.0
    let sideBarTableViewTopInset : CGFloat = 0
    let sideBarContainerView : UIView = UIView()
    let sideBarTableViewController : SideBarTableViewController = SideBarTableViewController()
    
    var originView : UIView!
    var animator : UIDynamicAnimator!
    var delegate : SideBarDelegate?
    var isSideBarOpen : Bool = false
    var requestingInitialPlace: Bool = false
    var selectedKnotIndex: Int = 0
    
    override init() {
        super.init()
    }

    init(sourceView : UIView, sideBarItems: Array<Knot>,_ navBarHeight : CGFloat?){
        super.init()
        originView = sourceView
        sideBarTableViewController.items = sideBarItems
        
        setupSideBar(navBarHeight)
        
        animator = UIDynamicAnimator(referenceView: originView)
        
        let showGestureRecognizer : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        showGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.right
        originView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        hideGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        originView.addGestureRecognizer(hideGestureRecognizer)
    }
    
    func setupSideBar(_ navBarHeight : CGFloat?) {
        sideBarContainerView.frame = CGRect(x: -barWidth - 1, y: navBarHeight!, width: barWidth, height: originView.frame.size.height - navBarHeight!)
        sideBarContainerView.backgroundColor = UIColor.clear
        sideBarContainerView.clipsToBounds = false
        
        originView.addSubview(sideBarContainerView)
        
        let blurView : UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
        blurView.frame = sideBarContainerView.bounds
        sideBarContainerView.addSubview(blurView)
        
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = true
        sideBarTableViewController.tableView.backgroundColor = UIColor.clear
        sideBarTableViewController.tableView.separatorStyle = .none
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsets(top: sideBarTableViewTopInset, left: 0, bottom: 0, right: 0)
        
        sideBarTableViewController.tableView.reloadData()
        
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
    }
    
    @objc func handleSwipe(recognizer : UISwipeGestureRecognizer) {
        if recognizer.direction == UISwipeGestureRecognizer.Direction.left {
            showSideBar(false)
            delegate?.sideBarWillClose?()
        } else {
            showSideBar(true)
            delegate?.sideBarWillOpen?()
        }
    }
    
    func showSideBar(_ shouldOpen : Bool) {
        animator.removeAllBehaviors()
        isSideBarOpen = shouldOpen
        
        let forceX : CGFloat = (shouldOpen) ? 0.5 : -0.5
        let magnitude : CGFloat = (shouldOpen) ? 20 : -20
        let boundaryX : CGFloat = (shouldOpen) ? barWidth : -barWidth - 1
        
        let forceBehavior : UIGravityBehavior = UIGravityBehavior(items: [sideBarContainerView])
        forceBehavior.gravityDirection = CGVector(dx: forceX, dy: 0)
        animator.addBehavior(forceBehavior)
        
        let collisionBehavior : UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehavior.addBoundary(withIdentifier: "sideBarBoundary" as NSCopying, from: CGPoint(x: boundaryX, y: 20), to: CGPoint(x: boundaryX, y: originView.frame.size.height))
        animator.addBehavior(collisionBehavior)
        
        let pushBehavior : UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehavior.Mode.instantaneous)
        pushBehavior.magnitude = magnitude
        animator.addBehavior(pushBehavior)
        
        let sideBarBehavior : UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehavior.elasticity = 0.3
        animator.addBehavior(sideBarBehavior)
    }
    
    func sideBarControlDidSelectSection(_ indexPath: IndexPath) {
        delegate?.sideBarDidSelectButtonAtIndex(index: indexPath.row)
        selectedKnotIndex = indexPath.row
        requestingInitialPlace = true
    }
}
