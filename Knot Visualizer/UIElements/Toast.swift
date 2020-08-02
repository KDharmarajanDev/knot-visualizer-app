//
//  Toast.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 8/1/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

import UIKit

class Toast {
    static func show(_ message: String,_ controller: UIViewController) {
        let toastContainer = UIView()
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds = true

        let toastLabel = UILabel()
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0

        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let toastContainerConstraints = [
            toastContainer.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 65),
            toastContainer.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -65),
            toastContainer.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: -120)
        ]
        NSLayoutConstraint.activate(toastContainerConstraints)

        let toastLabelConstraints = [
            toastLabel.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 15),
            toastLabel.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -15),
            toastLabel.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 15),
            toastLabel.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(toastLabelConstraints)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
