//
//  CollectionViewHEader.swift
//  CollectionViewHeaderTest1
//
//  Created by NHNEnt on 28/08/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewHeader: UICollectionReusableView {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.purple
        
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.white
        label.text = "HEADER .. 가운데 확인"
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[label]|", options: .alignAllCenterX, metrics: nil, views: ["label": label]) +
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[label]|", options: .alignAllCenterY, metrics: nil, views: ["label": label])
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        
//        debugPrint("layoutAttributes.origin :: \(layoutAttributes.frame.origin)")
//        debugPrint("layoutAttributes.size :: \(layoutAttributes.frame.size)")
//        
//        super.preferredLayoutAttributesFitting(layoutAttributes)
//        
//        return layoutAttributes
//    }

}



