//
//  Camera.swift
//  unify10shots
//
//  Created by Garret Kaye on 3/24/17.
//  Copyright © 2017 Garret Kaye. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class Camera: UIView {
    
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    var stillImageOutput = AVCaptureStillImageOutput()
    var photoBurstTimer = Timer()
    var currentPhotoCount = 0
    
    var takePhotoButton = UIButton()

    init () {
        super.init(frame: UIScreen.main.bounds)
        
        let screenSize = UIScreen.main.bounds.size
        
        
        self.frame.size = screenSize
        let cameraLocX = CGFloat(0)
        let cameraLocY = CGFloat(0)
        self.frame.origin = CGPoint(x: cameraLocX, y: cameraLocY)
        self.backgroundColor = UIColor.black
        
        takePhotoButton.frame.size = CGSize(width: 250, height: 80)
        takePhotoButton.frame.origin = CGPoint(x: (self.frame.size.width/2) - (takePhotoButton.frame.size.width/2), y: (self.frame.size.height) - (takePhotoButton.frame.size.height*1.5))
        takePhotoButton.layer.borderColor = UIColor.white.cgColor
        takePhotoButton.layer.borderWidth = 5
        takePhotoButton.layer.cornerRadius = 10
        takePhotoButton.setTitle("Take Ten Photos", for: .normal)
        takePhotoButton.setTitleColor(UIColor.white, for: .normal)
        takePhotoButton.addTarget(self, action: #selector(Camera.takePhotoBurst), for: .touchUpInside)
        self.addSubview(takePhotoButton)

        
        
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        let devices = AVCaptureDevice.devices()
        for device in devices! {
            if ((device as AnyObject).hasMediaType(AVMediaTypeVideo)) {
                if((device as AnyObject).position == AVCaptureDevicePosition.front) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        beginSession()
                    }
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginSession() {
        
        do {
            try self.captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
        }
        catch {
            print(error)
        }
        
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.layer.frame
        self.addSubview(self.takePhotoButton)
        captureSession.startRunning()
        stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        if captureSession.canAddOutput(stillImageOutput) {
            captureSession.addOutput(stillImageOutput)
        }
    }
    
    
    func takePhotoBurst (_ sender:UIButton) {
        
            self.photoBurstTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.capturePictures), userInfo: nil, repeats: true);
        
        
    }
    
    func capturePictures () {
        
        self.currentPhotoCount+=1
        if (self.currentPhotoCount > 10) {
            self.photoBurstTimer.invalidate()
            return
        }
        
        
        
        let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo)
        
        
        if videoConnection != nil {
            
            videoConnection!.videoOrientation = AVCaptureVideoOrientation(rawValue: UIDevice.current.orientation.rawValue)!
            
            
            
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection!)
            { (imageDataSampleBuffer, error) -> Void in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                
                tenShotsArray.insert(UIImage(data: imageData!)!, at: 0)
                
                print(self.currentPhotoCount)
                
                if (self.currentPhotoCount > 10) {
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "DidTakePicture"), object: PhotoCollectionView.self)
                    
                    var count = 0
                    
                    for img in tenShotsArray {
                        count+=1
                        self.saveImage(img, key: "image\(count)")
                    }
                    
                    
                }

                
                
            }
        }
        

        
    }
    
    
    func saveImage(_ imageToSave:UIImage, key:String) {
        
        // Declare user default var
        let userDefaults:UserDefaults = UserDefaults.standard
        
        let imageData = UIImageJPEGRepresentation(imageToSave, 1)
        let relativePath = "image_\(Date.timeIntervalSinceReferenceDate).jpg"
        let path = documentsPathForFileName(relativePath)
        try? imageData!.write(to: URL(fileURLWithPath: path), options: [.atomic])
        userDefaults.set(relativePath, forKey: key)
        
        // Save changes
        userDefaults.synchronize()
        
    }
    
    
    
    
}
