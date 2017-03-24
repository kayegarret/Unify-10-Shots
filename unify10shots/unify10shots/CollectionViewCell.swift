//
//  CollectionViewCell.swift
//  unify10shots
//
//  Created by Garret Kaye on 3/24/17.
//  Copyright © 2017 Garret Kaye. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var profilePic:UIImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame.size = CGSize(width: 100, height: 100)
        self.backgroundColor = UIColor.white
        
        // Profile pic
        self.profilePic.frame.size = CGSize(width: self.frame.size.width*(2/3), height: self.frame.size.width*(2/3))
        self.profilePic.center.y = self.frame.size.height/2
        self.profilePic.frame.origin.x = 15
        self.profilePic.layer.cornerRadius = 5
        self.profilePic.layer.masksToBounds = true
        self.addSubview(self.profilePic)
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
