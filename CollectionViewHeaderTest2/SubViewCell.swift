//
//  SubViewCell.swift
//  CollectionViewHeaderTest2
//
//  Created by NHNEnt on 19/09/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

class SubViewCell: UICollectionViewCell {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[label]-0-|", metrics: nil, views: ["label": label]) +
        NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[label]-0-|", metrics: nil, views: ["label": label]))
    }
    
    func bindData(txt: String) {
        backgroundColor = UIColor.random()
        label.text = txt
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    static func random() -> UIColor{
        return UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: 1.0
        )
    }
}
