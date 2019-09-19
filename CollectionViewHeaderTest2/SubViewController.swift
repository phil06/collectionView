//
//  SubViewController.swift
//  CollectionViewHeaderTest2
//
//  Created by NHNEnt on 19/09/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SubMenuDelegate: class {
    @objc optional func didLayoutSubviews(size: CGSize)
}


class SubViewController: UIViewController {
    
    var dataSource: [String] = []
    
    var collectionView: UICollectionView!
    
    var contentSize: CGSize = CGSize.zero
    
    weak var delegate: SubMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(SubViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(SubViewCell.self))
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", metrics: nil, views: ["collectionView": collectionView]) + NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", metrics: nil, views: ["collectionView": collectionView]))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.delegate?.didLayoutSubviews?(size: self.collectionView.collectionViewLayout.collectionViewContentSize)
    }
}

extension SubViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(SubViewCell.self), for: indexPath) as! SubViewCell
        cell.bindData(txt: dataSource[indexPath.row])
        return cell
    }
}

extension SubViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}
