//
//  KnotStateEditorAndPlayer.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/31/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

import UIKit

protocol KnotStateEditorDelegate {
    func selectedKnotState(index:Int)
}

class KnotStateEditorAndPlayer: NSObject {

    let rootView: UIView = UIView()
    let knotStateSlider: UISlider = UISlider()
    let goBackButton: UIButton = UIButton()
    let goForwardButton: UIButton = UIButton()
    
    var knot: Knot! {
        didSet {
            updateSliderToKnot()
        }
    }
    var originView: UIView!
    var delegate: KnotStateEditorDelegate?
    
    init(_ knot: Knot?,_ originView: UIView){
        super.init()
        self.knot = knot
        self.originView = originView
        originView.addSubview(rootView)
        
        setupRootView()
        setupGoBackButton()
        setupGoForwardButton()
        setupSlider()
    }
    
    func setupRootView(){
        rootView.backgroundColor = .clear
        rootView.isHidden = true
        setupRootViewConstraints()
        
        setupBlurView()

        rootView.addSubview(knotStateSlider)
        rootView.addSubview(goBackButton)
        rootView.addSubview(goForwardButton)
    }
    
    
    func setupRootViewConstraints() {
        rootView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            rootView.centerXAnchor.constraint(equalTo: originView.centerXAnchor),
            rootView.centerYAnchor.constraint(equalTo: originView.bottomAnchor, constant: -70),
            rootView.widthAnchor.constraint(equalTo: originView.widthAnchor, multiplier: 0.7),
            rootView.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBlurView() {
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
        rootView.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            blurView.leftAnchor.constraint(equalTo: rootView.leftAnchor),
            blurView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            blurView.rightAnchor.constraint(equalTo: rootView.rightAnchor),
            blurView.topAnchor.constraint(equalTo: rootView.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
    }
    
    func setupGoBackButton() {
        goBackButton.setTitle("", for: .normal)
        goBackButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        goBackButton.addTarget(self, action: #selector(onBackButtonPress(_:)), for: .touchUpInside)
        setupGoBackButtonConstraints()
    }
    
    func setupGoBackButtonConstraints() {
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            goBackButton.topAnchor.constraint(equalTo: rootView.topAnchor),
            goBackButton.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            goBackButton.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 10),
            goBackButton.widthAnchor.constraint(equalTo: goBackButton.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func onBackButtonPress(_ sender: UIButton) {
        changeInKnotStateRequested(index: knot.currIndex-1)
    }
    
    func setupSlider() {
        updateSliderToKnot()
        knotStateSlider.isContinuous = false
        knotStateSlider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        knotStateSlider.thumbTintColor = rootView.traitCollection.userInterfaceStyle == .dark ? .black : .white
        knotStateSlider.maximumTrackTintColor = rootView.traitCollection.userInterfaceStyle == .dark ? .gray : .lightGray
        setupSliderConstraints()
    }
    
    func updateSliderToKnot() {
        knotStateSlider.minimumValue = 0
        knotStateSlider.maximumValue = Float(knot.knotStates.count) - 1
        knotStateSlider.setValue(Float(knot.currIndex), animated: false)
    }
    
    func setupSliderConstraints() {
        knotStateSlider.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            knotStateSlider.topAnchor.constraint(equalTo: rootView.topAnchor),
            knotStateSlider.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            knotStateSlider.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            knotStateSlider.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            knotStateSlider.leftAnchor.constraint(equalTo: goBackButton.rightAnchor, constant: 10),
            knotStateSlider.rightAnchor.constraint(equalTo: goForwardButton.leftAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        let roundedStepValue = round(sender.value)
        changeInKnotStateRequested(index: Int(roundedStepValue))
    }
    
    func setupGoForwardButton() {
        goForwardButton.setTitle("", for: .normal)
        goForwardButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        goForwardButton.addTarget(self, action: #selector(onForwardButtonPressed(_:)), for: .touchUpInside)
        setupGoForwardButtonConstraints()
    }
    
    func setupGoForwardButtonConstraints() {
        goForwardButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            goForwardButton.topAnchor.constraint(equalTo: rootView.topAnchor),
            goForwardButton.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            goForwardButton.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -10),
            goForwardButton.widthAnchor.constraint(equalTo: goForwardButton.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func onForwardButtonPressed(_ sender: UIButton) {
        changeInKnotStateRequested(index: knot.currIndex+1)
    }
    
    func changeInKnotStateRequested(index: Int){
        if index < knot.knotStates.count && index >= 0 {
            knot.currIndex = index
            knotStateSlider.setValue(Float(index), animated: true)
            delegate?.selectedKnotState(index: index)
        }
    }
}
