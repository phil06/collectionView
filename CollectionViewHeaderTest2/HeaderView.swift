//
//  HeaderView.swift
//  CollectionViewHeaderTest2
//
//  Created by NHNEnt on 19/09/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    
    var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.red
        
        label = UILabel()
        label.text = "헤더"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = .center
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
   
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[label]-0-|", metrics: nil, views: ["label": label]) +
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[label]-0-|", metrics: nil, views: ["label": label]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
