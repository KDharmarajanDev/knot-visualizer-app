//
//  KnotTableViewCell.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/28/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

import UIKit
class ProductCell : UITableViewCell {
 
    var knot : Knot? {
        didSet {
            knotImage.image = knot?.thumbnail
            knotNameLabel.text = knot?.name
        }
    }
 
    private let knotNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
 
    private let knotImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
 
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.backgroundColor = UIColor.white
        addSubview(knotImage)
        addSubview(knotNameLabel)

        knotImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        knotNameLabel.anchor(top: topAnchor, left: knotImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
