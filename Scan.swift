//
//  Scan.swift
//  SwiftPrototype
//
//  Created by Hieu Tran on 12/15/14.
//  Copyright (c) 2014 Hieu Tran. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Scan : UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    var captureSession:AVCaptureSession?
    //var captureDeviceInput:AVCaptureDeviceInput?
    var captureMetaDataOutput:AVCaptureMetadataOutput?
    var captureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
  //  var captureDevice:AVCaptureDevice?
  //  var scannerRec:CGRect?
    var scannerButton:UIButton?
    var scannerView:UIView?
    var scannerLabel:UILabel?
    
    var QRCode:String!
    var EAN13Code:String!
    var EAN8Code:String!
    var Code128Code:String!
    var Code39Code:String!
    var AztecCode:String!
    var Code39Mod43Code:String!
    var Code93Code:String!
    var PDF417Code:String!
    var UPCECode:String!
    
    var barcodeDictionary = [String:String]()
    //Step to create barcode reader from phone camera
    //Check for camera
    //Create a Rectangle box grow and shrink upon the item in the box
    //Let the box do autofocus to read the barcode
    //Read the barcode
    //Save the barcode
    
    ///Constructor for first view
    override func viewDidLoad() {
        super.viewDidLoad()
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let captureDeviceInput: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if error == nil {
            println("\(error?.localizedDescription)")
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(captureDeviceInput as AVCaptureInput)
        
        captureMetaDataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetaDataOutput)
        
        captureMetaDataOutput?.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetaDataOutput?.metadataObjectTypes = captureMetaDataOutput?.availableMetadataObjectTypes
        
        captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        captureVideoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(captureVideoPreviewLayer)
        
    //    overlayButtonInit()
    //    overlayLabelInit()
        overlayScannerInit()
        
        captureSession?.startRunning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///init the the button
    func overlayButtonInit(){
        scannerButton = UIButton()
        scannerButton?.titleLabel?.text = "Generate"
        scannerButton?.frame = CGRectMake(100, 50, 100, 50)
        scannerButton?.addTarget(self, action:Selector(scanButtonPressed()) ,
                             forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(scannerButton!)
        self.view.bringSubviewToFront(scannerButton!)
    }
    
    ///init the label
    func overlayLabelInit(){
        scannerLabel = UILabel()
        scannerLabel?.textColor = UIColor.blueColor()
        scannerLabel?.text = "Scanning..."
        self.view.addSubview(scannerLabel!)
        self.view.bringSubviewToFront(scannerLabel!)
    }
    
    ///init the scanner
    func overlayScannerInit(){
        scannerView = UIView()
        scannerView?.layer.borderColor = UIColor.blueColor().CGColor
        scannerView?.layer.borderWidth = 4
        scannerLabel?.hidden = true
        self.view.addSubview(scannerLabel!)
        self.view.bringSubviewToFront(scannerLabel!)
    }
    
    ///action for the button
    func scanButtonPressed(){
        scannerLabel?.hidden = false
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self,
                                                selector:Selector(hideLabel()),
                                                userInfo:nil,
                                                 repeats: false)
        
    }
    
    ///hide the label
    func hideLabel(){
        scannerLabel?.hidden = true
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        //check to see if the metaobject array is nil or empty
        if metadataObjects == nil || metadataObjects.count == 0 {
            scannerView?.frame = CGRectZero
            //TODO send a message to the screen
            return
        }

        //find the correct barcode
        for metaDataObj in metadataObjects {
            if metaDataObj.type == AVMetadataObjectTypeQRCode {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("QRCode: \(barcodeObj.stringValue)")
                    QRCode = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypeEAN13Code {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("EAN13Code: \(barcodeObj.stringValue)")
                    EAN13Code = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypeEAN8Code {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("EAN8Code: \(barcodeObj.stringValue)")
                    EAN8Code = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypeCode128Code {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("Code128Code: \(barcodeObj.stringValue)")
                    Code128Code = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypeCode39Code {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("Code39Code: \(barcodeObj.stringValue)")
                    Code39Code = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypeAztecCode {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("AztecCode: \(barcodeObj.stringValue)")
                    AztecCode = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypeCode39Mod43Code {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("Code39Mod43Code: \(barcodeObj.stringValue)")
                    Code39Mod43Code = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypeCode93Code {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("Code93Code: \(barcodeObj.stringValue)")
                    Code39Code = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypePDF417Code {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("PDF417Code: \(barcodeObj.stringValue)")
                    PDF417Code = barcodeObj.stringValue
                }
            } else if metaDataObj.type == AVMetadataObjectTypeUPCECode {
                let barcodeObj = captureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
                scannerView?.bounds = barcodeObj.bounds
                if barcodeObj.stringValue != nil {
                    println("UPCECode: \(barcodeObj.stringValue)")
                    UPCECode = barcodeObj.stringValue
                }
            }
        }
    }
    ///send datatype through views
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var _Card = Card()
        if QRCode != nil {
            _Card.QRCode = QRCode
        }else if EAN13Code != nil {
            _Card.EAN13Code = EAN13Code
        }else if EAN8Code != nil {
            _Card.EAN8Code = EAN8Code
        }else if Code128Code != nil {
            _Card.Code128Code = Code128Code
        }else if Code39Code != nil {
            _Card.Code39Code = Code39Code
        }else if AztecCode != nil {
            _Card.AztecCode = AztecCode
        }else if Code39Mod43Code != nil {
            _Card.Code39Mod43Code = Code39Mod43Code
        }else if Code93Code != nil {
            _Card.Code93Code = Code93Code
        }else if PDF417Code != nil {
            _Card.PDF417Code = PDF417Code
        }else if UPCECode != nil {
            _Card.UPCECode = UPCECode
        }else{
            println("No barcode")
        }
    }
}
