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
    let sideBarContainerView : UIView = UIView()
    let sideBarTableViewController : SideBarTableViewController = SideBarTableViewController()
    
    var originView : UIView!
    var delegate : SideBarDelegate?
    var isSideBarOpen : Bool = false
    var requestingInitialPlace: Bool = false
    var selectedKnotIndex: Int = 0
    
    var sideBarContainerViewCenterXAnchor: NSLayoutConstraint = NSLayoutConstraint()
    
    override init() {
        super.init()
    }

    init(sourceView : UIView, sideBarItems: Array<Knot>){
        super.init()
        originView = sourceView
        sideBarTableViewController.items = sideBarItems

        setupSideBar()
    
        let showGestureRecognizer : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        showGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.right
        originView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        hideGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        originView.addGestureRecognizer(hideGestureRecognizer)
    }
    
    func setupSideBar() {
        sideBarContainerView.backgroundColor = UIColor.clear
        sideBarContainerView.clipsToBounds = false
        originView.addSubview(sideBarContainerView)
        setupContainerViewConstraints()
        
        var blurView : UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
        sideBarContainerView.addSubview(blurView)
        setupBlurViewConstraints(&blurView)
        
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.clipsToBounds = true
        sideBarTableViewController.tableView.backgroundColor = UIColor.clear
        sideBarTableViewController.tableView.separatorStyle = .none
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.reloadData()
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
        setupTableViewConstraints()
    }
    
    func setupContainerViewConstraints() {
        sideBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        sideBarContainerViewCenterXAnchor = sideBarContainerView.centerXAnchor.constraint(equalTo: originView.leftAnchor, constant: -(barWidth / 2.0))
        let constraints = [
            sideBarContainerView.bottomAnchor.constraint(equalTo: originView.bottomAnchor),
            sideBarContainerView.widthAnchor.constraint(equalToConstant: barWidth),
            sideBarContainerView.topAnchor.constraint(equalTo: originView.safeAreaLayoutGuide.topAnchor),
            sideBarContainerViewCenterXAnchor
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBlurViewConstraints(_ blurView: inout UIVisualEffectView) {
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            blurView.leftAnchor.constraint(equalTo: sideBarContainerView.leftAnchor),
            blurView.rightAnchor.constraint(equalTo: sideBarContainerView.rightAnchor),
            blurView.bottomAnchor.constraint(equalTo: sideBarContainerView.bottomAnchor),
            blurView.topAnchor.constraint(equalTo: sideBarContainerView.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupTableViewConstraints() {
        sideBarTableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            sideBarTableViewController.tableView.topAnchor.constraint(equalTo: sideBarContainerView.topAnchor),
            sideBarTableViewController.tableView.bottomAnchor.constraint(equalTo: sideBarContainerView.bottomAnchor),
            sideBarTableViewController.tableView.leftAnchor.constraint(equalTo: sideBarContainerView.leftAnchor),
            sideBarTableViewController.tableView.rightAnchor.constraint(equalTo: sideBarContainerView.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
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
        isSideBarOpen = shouldOpen
        let centerXConstant = shouldOpen ? (barWidth/2.0): -(barWidth/2.0)
        sideBarContainerViewCenterXAnchor.constant = centerXConstant
        UIView.animate(withDuration: 1.25, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, animations: {
            self.sideBarContainerView.superview?.layoutIfNeeded()
        })
    }
    
    func sideBarControlDidSelectSection(_ indexPath: IndexPath) {
        delegate?.sideBarDidSelectButtonAtIndex(index: indexPath.row)
        selectedKnotIndex = indexPath.row
        requestingInitialPlace = true
    }
}
