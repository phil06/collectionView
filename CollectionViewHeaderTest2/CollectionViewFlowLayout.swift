//
//  CollectionViewFlowLayout.swift
//  CollectionViewHeaderTest2
//
//  Created by NHNEnt on 19/09/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var isMaxFittedWidth: Bool = false
    var isSticky: Bool = false {
        didSet {
            self.sectionHeadersPinToVisibleBounds = isSticky
        }
    }
    var safeAreaInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        
        adjustAttributes([attributes])
        
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        adjustAttributes(attributes)
        
        
        
        return attributes
    }
    
    private func adjustAttributes(_ attr: [UICollectionViewLayoutAttributes]) {
        
        
        
        for attribute in attr {
            
            switch attribute.representedElementKind {
                
            case UICollectionView.elementKindSectionHeader?:
                if isSticky {
                    guard let collectionView = collectionView else { break }
                    guard attribute.indexPath.section == 0 else { break }

                    if (collectionView.contentOffset.y + safeAreaInsets.top) < 0 {
                        attribute.frame.origin.y = (collectionView.contentOffset.y + safeAreaInsets.top)
                    } else {
                        attribute.frame.origin.y = attribute.frame.origin.y * 0.5
                    }
                }
                
            case UICollectionView.elementKindSectionFooter?:
                break
                
            default:
                
                
                if isMaxFittedWidth {
                    attribute.frame.size.width = UIScreen.main.bounds.width
                    attribute.frame.origin.x = 0
                }
                break
            }
            
        }
    }
    
}
