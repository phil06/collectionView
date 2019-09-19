//
//  ViewController.swift
//  CollectionViewHeaderTest2
//
//  Created by NHNEnt on 19/09/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var datasource: [[String]] = [[],[]]
    
    var subMenuVcs: [SubViewController] = [SubViewController(), SubViewController()]
    var currentSubMenuIdx: Int!
    
    var cellSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1)

    var gestureDirection: UISwipeGestureRecognizer.Direction = .left
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currentSubMenuIdx = 0
        
        let layout = CollectionViewFlowLayout()
        layout.isSticky = true

        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HostedCell.self, forCellWithReuseIdentifier: NSStringFromClass(HostedCell.self))
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(HeaderView.self))
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", metrics: nil, views: ["collectionView": collectionView]) +
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", metrics: nil, views: ["collectionView": collectionView]))
        
        let swipeGestureToRight = UISwipeGestureRecognizer(target: self, action: #selector(switchSubMenu))
        swipeGestureToRight.direction = .right
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(swipeGestureToRight)
        
        let swipeGestureToLeft = UISwipeGestureRecognizer(target: self, action: #selector(switchSubMenu))
        swipeGestureToLeft.direction = .left
        self.view.addGestureRecognizer(swipeGestureToLeft)
        
        fetch()
    }
    
    override func viewDidLayoutSubviews() {
        (collectionView.collectionViewLayout as? CollectionViewFlowLayout)?.safeAreaInsets = view.safeAreaInsets
    }
    
    func fetch() {
        datasource = [["O_1","O_2","O_3","O_4","O_5","O_6","O_7","O-8","O_9","O_10","O_11","O_12","O_13","O_14","O_15"],["NEW_99","NEW_98","NEW_97","NEW_96","NEW_95","NEW_94","NEW_93"]]
        
        subMenuVcs[0].dataSource = datasource[0]
        subMenuVcs[1].dataSource = datasource[1]
        
        subMenuVcs[0].delegate = self
        subMenuVcs[1].delegate = self
        
        addChild(subMenuVcs[0])
        subMenuVcs[0].didMove(toParent: self)
        
        collectionView.reloadData()
    }
    
    @objc func switchSubMenu(recognizer: UISwipeGestureRecognizer) {
        
        if recognizer.direction == .right {
            gestureDirection = .right
            currentSubMenuIdx = currentSubMenuIdx == 0 ? 1 : 0 //for loop
        } else if recognizer.direction == .left {
            gestureDirection = .left
            currentSubMenuIdx = currentSubMenuIdx == 1 ? 0 : 1
        }
        
        DispatchQueue.main.async {
            var offset = CGPoint.zero
            debugPrint("self.view.safeAreaInsets.top : \(self.view.safeAreaInsets.top)")
            offset.y = offset.y - self.view.safeAreaInsets.top
            self.collectionView.setContentOffset(offset, animated: false)
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 250)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(HeaderView.self), for: indexPath) as? HeaderView {
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(HostedCell.self), for: indexPath) as! HostedCell
        
        guard subMenuVcs.count > 0 else {
            return cell
        }
        
        cell.hostedView = subMenuVcs[currentSubMenuIdx].view
        
        UIView.animate(withDuration: 0.5, delay: 2, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: gestureDirection == .right ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
            
            if self.gestureDirection == .right {
                //FromLefttoRight
                var transition: CATransition? = nil
                transition = CATransition.init()
                transition?.duration = 0.4
                transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition?.type = CATransitionType.push
                transition?.subtype = CATransitionSubtype.fromLeft
                cell.layer.add(transition!, forKey: nil)
            } else {
                //FromRighttoLeft
                var transition: CATransition? = nil
                transition = CATransition.init()
                transition?.duration = 0.4
                transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition?.type = CATransitionType.push
                transition?.subtype = CATransitionSubtype.fromRight
                cell.layer.add(transition!, forKey: nil)
            }
            
        }, completion: { (done) in
            
        })

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = -1
    }
    
}

extension ViewController: SubMenuDelegate {
    func didLayoutSubviews(size: CGSize) {
        cellSize = size
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
