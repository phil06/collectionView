//
//  CollectionViewCell.swift
//  CollectionViewHeaderTest1
//
//  Created by NHNEnt on 28/08/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.orange
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: .alignAllCenterX, metrics: nil, views: ["label": label]) +
                NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: .alignAllCenterY, metrics: nil, views: ["label": label])
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel(txt: String) {
        label.text = txt
    }
}
