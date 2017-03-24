//
//  PhotoCollectionView.swift
//  unify10shots
//
//  Created by Garret Kaye on 3/24/17.
//  Copyright © 2017 Garret Kaye. All rights reserved.
//

import UIKit

//----------------------------------------

public var tenShotsArray = [UIImage]()

//----------------------------------------

class PhotoCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var collectionView:UICollectionView!
    var headingLabel = UILabel()
    

    init () {
        super.init(frame: UIScreen.main.bounds)
        
        let screenSize = UIScreen.main.bounds.size
        
        
        self.frame.size = screenSize
        let cameraLocX = CGFloat(-screenSize.width)
        let cameraLocY = CGFloat(0)
        self.frame.origin = CGPoint(x: cameraLocX, y: cameraLocY)
        self.backgroundColor = UIColor.white
        
        self.headingLabel.frame.size = CGSize(width: screenSize.width, height: screenSize.height/10)
        self.headingLabel.frame.origin = CGPoint(x: 0, y: 0)
        self.headingLabel.textAlignment = .center
        self.headingLabel.text = "Photos"
        self.headingLabel.textColor = UIColor.black
        self.addSubview(headingLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        self.collectionView.frame.size = CGSize(width: self.frame.size.width, height: self.frame.size.height*0.9)
        self.collectionView.frame.origin = CGPoint(x: 0, y: self.frame.size.height/10)
        self.collectionView.backgroundColor = UIColor.white
        self.addSubview(self.collectionView)
        
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CollectionViewCell.self))
        
        NotificationCenter.default.addObserver(self, selector: #selector(PhotoCollectionView.refresh(_:)), name: NSNotification.Name(rawValue: "DidTakePicture"), object: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell( withReuseIdentifier: NSStringFromClass(CollectionViewCell.self), for: indexPath) as? CollectionViewCell
        
        cell?.profilePic.image = tenShotsArray[indexPath.row]
        
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tenShotsArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func refresh(_ notification:Notification) {
        
        UIView.animate(withDuration: 0.75, animations: {
            self.frame.origin.x = 0
        })
        
        self.collectionView.reloadData()
    }
    
    
    
}

