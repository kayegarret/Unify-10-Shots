//
//  ViewController.swift
//  unify10shots
//
//  Created by Garret Kaye on 3/24/17.
//  Copyright © 2017 Garret Kaye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var photoCollectionView = PhotoCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults:UserDefaults = UserDefaults.standard
        var foundNil = false
        
        for index in 1...10 {
            if (userDefaults.object(forKey: "image\(index)") == nil) {
                foundNil = true
                break
            }
            else {
                tenShotsArray.insert(loadImage("image\(index)"), at: 0)
            }
        }
        
        if foundNil == true {
            self.view.addSubview(Camera())
            self.view.addSubview(photoCollectionView)

        }
        else {
            self.view.addSubview(photoCollectionView)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "DidTakePicture"), object: PhotoCollectionView.self)
        }
        
        
        
        print(self.view.frame.size)
        
        
        
        self.view.backgroundColor = UIColor.black

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    
    
    func loadImage(_ key:String) -> UIImage {
        
        // Declare user default var
        let userDefaults:UserDefaults = UserDefaults.standard
        
        var imageToPass:UIImage = UIImage()
        
        
        let possibleOldImagePath = userDefaults.object(forKey: key) as! String?
        if let oldImagePath = possibleOldImagePath {
            let oldFullPath = documentsPathForFileName(oldImagePath)
            let oldImageData = try? Data(contentsOf: URL(fileURLWithPath: oldFullPath))
            // saved image:
            imageToPass = UIImage(data: oldImageData!)!
        }
        
        
        return imageToPass
        
    }
    


}


public func documentsPathForFileName(_ name: String) -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
    let path = paths[0] as NSString
    let fullPath = path.appendingPathComponent(name)
    
    return fullPath
}
