//
//  CaptureViewController.swift
//  PhotoStream
//
//  Created by Pierre-Olivier on 03/10/2024.
//

import Foundation
import UIKit
import AVFoundation

class CaptureViewController : UIViewController, AVCapturePhotoCaptureDelegate {
    
    private var captureSession: AVCaptureSession!
    private var photoOutput: AVCapturePhotoOutput!
    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer!
    private var photoSettings: AVCapturePhotoSettings!
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCameraSession()
    }
    
    private func setupCameraSession() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        photoOutput = AVCapturePhotoOutput()
        
        if (captureSession.canAddOutput(photoOutput)) {
            captureSession.addOutput(photoOutput)
        } else {
            return
        }
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.frame = view.layer.bounds
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.insertSublayer(cameraPreviewLayer, at: 0)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    @IBAction func takePicture(_ sender: Any) {
        photoSettings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: imageData)
        
        // Stop the capture session
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.stopRunning()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
