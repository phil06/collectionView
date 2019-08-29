//
//  ViewController.swift
//  CollectionViewHeaderTest1
//
//  Created by NHNEnt on 28/08/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource = ["SSSSS","HHHHH","IIIII","NNNNNN","EEEEEE","EEEEEEE"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupCollectionView()
    }
    
    func setupCollectionView() {
        var layout = CollectionFlowLayout()
            //UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.gray
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CollectionViewCell.self))
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(CollectionViewHeader.self))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[collectionView]-0-|", metrics: nil, views: ["collectionView": collectionView]) +
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", metrics: nil, views: ["collectionView": collectionView])
        )
        
        collectionView.collectionViewLayout.invalidateLayout()
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CollectionViewCell.self), for: indexPath) as? CollectionViewCell {
            cell.setLabel(txt: dataSource[indexPath.row])
            cell.layer.zPosition = 999
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(CollectionViewHeader.self), for: indexPath) as? CollectionViewHeader {
            return header
        }
        
        return UICollectionReusableView()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 130)
    }
}

extension ViewController: UICollectionViewDelegate {
    
}
