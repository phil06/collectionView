//
//  CollectionFlowLayout.swift
//  CollectionViewHeaderTest1
//
//  Created by NHNEnt on 28/08/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

class CollectionFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        
        switch attributes.representedElementKind {
        case UICollectionView.elementKindSectionHeader?:

            guard let collectionView = collectionView else { break }
            guard attributes.indexPath.section == 0 else { break }

            if collectionView.contentOffset.y < 0 {
                attributes.frame.origin.y = collectionView.contentOffset.y
            } else {
                attributes.frame.origin.y = attributes.frame.origin.y * 0.5
            }
            
        default:
            break
        }
        
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        return attributes
    }
    

}
