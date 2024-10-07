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
    
    private var syncingViewController: UIViewController?
    
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
        if (photoOutput != nil) {
            // Physical device
            photoSettings = AVCapturePhotoSettings()
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        } else {
            // Simulator
            // Mock result with an internal photo
            savePicture(image: UIImage(named: "Photo2")!)
        }
        
        // Instantiate the LoadingAlertViewController from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Adjust the name if needed
        syncingViewController = storyboard.instantiateViewController(withIdentifier: "SyncingViewControllerID") as? UIViewController
        if let syncingViewController = syncingViewController {
            if let presentationController = syncingViewController.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium()]
            }
            
            present(syncingViewController, animated: true, completion: nil)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // Stop the capture session
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.stopRunning()
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            closeController()
            return
        }
        
        let image = UIImage(data: imageData)
        savePicture(image: image!)
    }
    
    func savePicture(image: UIImage) {
        CollectionService.shared.generateAuthor() { response in
            CollectionService.shared.savePhoto(image: image, author: response.author)
            
            self.closeController()
        }
    }
    
    func closeController() {
        syncingViewController?.dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
