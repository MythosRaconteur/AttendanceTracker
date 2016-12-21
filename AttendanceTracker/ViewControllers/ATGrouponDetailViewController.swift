//
//  ATGrouponDetailViewController.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 12/12/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit
import AVFoundation

class ATGrouponDetailViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var grouponNumberTextField: UITextField!
    @IBOutlet weak var numberSessionsTextField: UITextField!
    @IBOutlet weak var purchaseDateButton: UIButton!
    @IBOutlet weak var expirationDateButton: UIButton!
    @IBOutlet weak var redeemedSwitch: UISwitch!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private var _model: ATGroupon?
    
    var model: ATGroupon? {
        get {
            return self._model
        }
        set {
            self._model = newValue
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let grouponModel = self.model {
            self.grouponNumberTextField.text = grouponModel.grouponNumber
            self.numberSessionsTextField.text = String(grouponModel.sessionTotal)
            
            let df = DateFormatter()
            df.dateFormat = "M/d/yyyy"
            
            self.purchaseDateButton.setTitle(df.string(from: grouponModel.purchaseDate!), for: .normal)
            
            var expStr = "NEVER"
            
            if let expDate = grouponModel.expirationDate {
                expStr = df.string(from: expDate)
            }
            
            self.expirationDateButton.setTitle(expStr, for: .normal)
            
            self.redeemedSwitch.isOn = grouponModel.hasBeenRedeemed
        }
        else {
            self.captureSession = AVCaptureSession()
            
            let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            
            let videoInput: AVCaptureDeviceInput?
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            }
            catch {
                return
            }
            
            if (self.captureSession.canAddInput(videoInput)) {
                self.captureSession.addInput(videoInput)
            }
            else {
                self.scanningNotPossible()
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            // Add output to the session.
            if (self.captureSession.canAddOutput(metadataOutput)) {
                self.captureSession.addOutput(metadataOutput)
                
                // Send captured data to the delegate object via a serial queue.
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                // Set barcode types for which to scan
                metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeUPCECode]
            }
            else {
                scanningNotPossible()
            }
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.frame = CGRect(x: view.layer.bounds.origin.x, y: view.layer.bounds.origin.y, width: view.layer.bounds.size.width, height: 300)
            self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.view.layer.addSublayer(previewLayer)
            
            // Begin the capture session.
            self.captureSession.startRunning()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Event Handlers
    
    @IBAction func handlePurchaseDateButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func handleExpirationDateButtonPressed(_ sender: UIButton) {
        
    }
    
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate implementation

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // Get the first object from the metadataObjects array.
        if let barcodeData = metadataObjects.first {
            // Turn it into machine readable code
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject
            
            if let readableCode = barcodeReadable {
                // Send the barcode as a string to barcodeDetected()
                barcodeDetected(code: readableCode.stringValue);
            }
            
            // Vibrate the device to give the user some feedback.
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            // Avoid a very buzzy device.
            self.captureSession.stopRunning()
        }
    }
    
    func barcodeDetected(code: String) {
        // Let the user know we've found something.
        let alert = UIAlertController(title: "Found a Barcode!", message: code, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Search", style: UIAlertActionStyle.destructive, handler: { action in
            let trimmedCode = code.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
            // EAN or UPC?
            // Check for added "0" at beginning of code.
            let trimmedCodeString = "\(trimmedCode)"
            var trimmedCodeNoZero: String
            
            if trimmedCodeString.hasPrefix("0") && trimmedCodeString.characters.count > 1 {
                trimmedCodeNoZero = String(trimmedCodeString.characters.dropFirst())
                
                print("0 Removed: \(trimmedCodeNoZero)")
            }
            else {
                print("No 0: \(trimmedCode)")
            }
            
            self.navigationController!.popViewController(animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func scanningNotPossible() {
        // Let the user know that scanning isn't possible with the current device.
        let alert = UIAlertController(title: "Cannot Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        self.captureSession = nil
    }
}
