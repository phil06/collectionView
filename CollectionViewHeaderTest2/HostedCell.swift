//
//  HostedCell.swift
//  CollectionViewHeaderTest2
//
//  Created by NHNEnt on 19/09/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

class HostedCell: UICollectionViewCell {
    
    var hostedView: UIView? {
        didSet {
            guard let view = hostedView else {
                return
            }
            
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", metrics: nil, views: ["view": view]) +
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", metrics: nil, views: ["view": view]))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if hostedView?.superview == contentView {
            hostedView?.removeFromSuperview()
        }
        
        hostedView = nil
    }
}
