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
        lbl.textColor = .black
        lbl.font = UIFont(name: "Arial Unicode MS", size: 12)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
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
//        contentView.addSubview(knotImage)

//        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    func setupBackground() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = CGFloat(8.0)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
    
    func setImageConstraints() {
        knotImage.translatesAutoresizingMaskIntoConstraints = false
        knotImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        knotImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
//        let aspectRatio : CGFloat = (knotImage.image?.size.height ?? 1) / (knotImage.image?.size.width ?? 1)
//        knotImage.widthAnchor.constraint(equalToConstant: 0.9 * frame.size.width).isActive = true
        knotImage.bottomAnchor.constraint(equalTo: knotImage.topAnchor, constant: 30).isActive = true
    }
    
    func setTitleLabelConstraints() {
        knotNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        knotNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        knotNameLabel.topAnchor.constraint(equalTo:
            contentView.topAnchor).isActive = true
        knotNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        knotNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        knotNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        knotNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
