//
//  KnotTableViewCell.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/28/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

import UIKit
class KnotCell : UITableViewCell {
 
    var knot : Knot? {
        didSet {
            knotImage.image = knot?.thumbnail
            knotNameLabel.text = knot?.name
        }
    }
 
    private let knotNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Arial Unicode MS", size: 2)
        lbl.textColor = .systemBlue
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
 
    private let knotImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 2.0
        imgView.clipsToBounds = true
        return imgView
    }()
 
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBackground()
        
        contentView.clipsToBounds = true
        contentView.addSubview(knotNameLabel)
        contentView.addSubview(knotImage)
                
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    func setupBackground() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        self.contentView.layer.cornerRadius = CGFloat(8.0)
    }
    
    func setImageConstraints() {
        knotImage.translatesAutoresizingMaskIntoConstraints = false
        knotImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        knotImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        knotImage.widthAnchor.constraint(equalToConstant: 125).isActive = true
        knotImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    func setTitleLabelConstraints() {
        knotNameLabel.translatesAutoresizingMaskIntoConstraints = false
        knotNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        knotNameLabel.topAnchor.constraint(equalTo:
            knotImage.bottomAnchor, constant: -5).isActive = true
        knotNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8))
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
